#!/usr/bin/ruby
# -*- coding: utf-8 -*- 

require 'cgi'

def getTdList(tds)
  td_list = Array.new
  tds.gsub(/<td(.*?)>(.*?)<\/td>/) {
    td_list << $2
  }
  return td_list
end

def getTrList(trs)
  tr_list = Array.new
  trs.gsub(/<tr>(.*?)<\/tr>/) {
    tr_list << $1
  }

  tr_list_s = Array.new
  tr_list.each {|tds|
    tr_list_s << getTdList(tds)
  }

  return tr_list_s
end

def getColumnWidthList(tr_list)
  col_size = tr_list.first.size
  max_col_width = 44

  col_width_list = Array.new
  col_size.times {|col|
    col_width_list << (tr_list.transpose[col].max {|a, b| a.length <=> b.length }).length
  }
  return col_width_list
end

def makeTableHead(col_width_list)
  result = "|"

  col_width_list.each {
    result = result + " |"
  }
  result = result + "\n|"

  col_width_list.each {|width|
    line = "-" * width
    result = result + line + "|"
  }

  return result
end

def makeTableBody(body, col_width_list)
  result = ""
  body.each {|row|
    if !result.empty?
      result = result + "\n"
    end
    result = result + "|"

    row.each {|data|
      data = data.gsub('|', '&#x7C;')
      result = result + data + " |"
    }
  }
  return result
end

# テーブルの解析
def parseTable(html)
  parse_result = html.gsub(/<table(.*?)><tbody>(.*?)<\/tbody><\/table>/){|matched|
    table = matched # <tr><td>...</td></tr>...</tr>
    tr_list = getTrList(table)
    col_width_list = getColumnWidthList(tr_list)

    body = tr_list

    result = "\n\n" + makeTableHead(col_width_list)
    result = result + "\n" + makeTableBody(tr_list, col_width_list) + "\n"

    result
  }
  return parse_result
end

def deleteTrash(html)
  html = html.gsub('<table class=\'sites-layout-name-one-column sites-layout-hbox\' cellspacing=\'0\'><tbody><tr><td class=\'sites-layout-tile sites-tile-name-content-1\'><div dir=\'ltr\'>', "")
  html = html.gsub('<table style=\'width:877px\' cellspacing=\'0\'><tbody><tr><td><div dir=\'ltr\'><div/>', "")
  html = html.gsub("<div>", "")
  html = html.gsub("</div>", "\n")

  html = html.gsub(/<p>(.*?)<\/p>/, "\n\\1\n")

  # 意味がないので削除
  html = html.gsub(/<font face=\'monospace\' color=\'#000000\'>(.*?)<\/font>/, '\1')
  html = html.gsub(/<font face=\'monospace\' color=\'#000000\'>(.*?)\n<\/font>/, '\1')
  html = html.gsub(/<font face=\'monospace\'>((\n|.)*?)<\/font>/, '\1')
  html = html.gsub(/<div style=\'color:rgb\(0,0,0\)\'>/, "")

  # ゴミ消し
  html = html.gsub('<font face=\'monospace\' color=\'#000000\'>', "")
  html = html.gsub('<font color=\'#000000\'>', "")
  html = html.gsub('<a name=(.*?)\/>', "")

  html = html.gsub("<br/>", "")
  html = html.gsub(/<a name=(.*?)>/, "")
  return html
end

def deleteAfterTrash(html)
  # 最終行を削除
  html = html.gsub("\n</td></tr></tbody></table>", "")

  # 連続する改行を削除
  html = html.gsub(/^\n\n/, "\n")

  # スペースのような何かをスペースに置き換え
  html = html.gsub(' ', ' ')

  html = html.gsub(/<div(.*?)>/, "")
  html = html.gsub("<div/>", "")
  html = html.gsub("<h2>", "")
  html = html.gsub("</h2>", "")
  html = html.gsub(/<font(.*?)>(.*?)<\/font>/, '\2')
  html = html.gsub(/<font(.*?)>/, '')
  html = html.gsub(/<span(.*?)>(.*?)<\/span>/, '\2')

  return html
end

def htmlToMarkdown(html_path)
  filename = File.basename(html_path, ".html")

  html = File.open(html_path).read

  # 参照文字をデコード
  html = CGI.unescapeHTML(html)

  # ゴミ消し
  html = deleteTrash(html)
 
  # 文字色
  html = html.gsub(/<font color=\'#ff0000\'>(.*?)<\/font>/, '<color=ff0000>\1</color>')
  html = html.gsub(/<font color=\'#000000\'>(.*?)<\/font>/, '\1') # 意味がないので無視
  html = html.gsub('</font>', '') # 消し残し

  # テーブル
  html = parseTable(html)

  # 見出し
  html = html.gsub(/<h2(.*?)>(.*?)<\/h2>/, "\n\n##\\2\n")
  html = html.gsub(/<h3><\/h3>/, '')
  html = html.gsub(/<h3(.*?)>(.*?)<\/h3>/, "\n\n###\\2\n")

  # 箇条書き
  html = html.gsub(/<li>(.*?)<\/li>/, "\n- \\1")
  html = html.gsub('<ul>', "")
  html = html.gsub('</ul>', "")

  # リンク
  html = html.gsub(/<a(.*?) href=\'(.*?)\'>(.*?)<\/a>/, '[\3](\2)')

  # コードブロックの開始
  html = html.gsub('<div class=\'sites-codeblock sites-codesnippet-block\'>', '<codeblock>')

  # コードの前後にある空行削除
  html = html.gsub(/<codeblock>\n*/, "<codeblock>\n")

  # コードブロックの終了
  html = html.gsub(/<codeblock>(.*?\n)\n+(?=\n)/m, "<codeblock>\\1</codeblock>")

  # コードブロック内のゴミ消し
  html = html.gsub(/<codeblock>(.*?)<\/codeblock>/m) {|codeblock|
    codeblock = codeblock.gsub('<code>', '').gsub('</code>', '')
  }

  html = html.gsub(/<codeblock>(.*?)<\/codeblock>/m) {
    qualify_list = Array.new
    codeblock = $1
    codeblock = codeblock.gsub(/\[(.*?)\]\((.*?)\)/) {
      qualify_list << {'name' => $1, 'link' => $2}
      $1
    }
    codeblock = codeblock.gsub(/<color=(.*?)>(.*?)<\/color>/) {
      qualify_list << {'name' => $2, 'color' => $1}
      $2
    }

    codeblock = '<codeblock>' + codeblock + '</codeblock>' + "\n"
    qualify_list.each {|qualify|
      qualify_str = qualify['name']
      
      if qualify['link']
        qualify_str = qualify_str + '[link: ' + qualify['link'] + ']'
      end

      if qualify['color']
        qualify_str = qualify_str + '[color: ' + qualify['color'] + ']'
      end
      qualify_str = qualify_str + "\n"
      codeblock = codeblock + qualify_str
    }
    codeblock
  }

  # バッククォートでコードブロック
  html = html.gsub(/<codeblock>/, '```cpp')
  html = html.gsub(/<\/codeblock>/, '```')

  # ゴミ消し
  html = deleteAfterTrash(html)

  File.open("#{filename}.md", "w") {|f|
    f.write(html)
  }

  #puts html
end

htmlToMarkdown('advance.html')
htmlToMarkdown('fetch_add.html')
htmlToMarkdown('atomic.html')

