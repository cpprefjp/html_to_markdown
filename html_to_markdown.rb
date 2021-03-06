#!/usr/bin/ruby
# -*- coding: utf-8 -*- 

require 'cgi'
require 'fileutils'

def getTdList(tds)
  td_list = Array.new
  tds.gsub(/<td(.*?)>(.*?)<\/td>/m) {
    td_list << $2
  }
  return td_list
end

def getTrList(trs)
  tr_list = Array.new
  trs.gsub(/<tr>(.*?)<\/tr>/m) {
    tr_list << $1
  }

  tr_list_s = Array.new
  tr_list.each {|tds|
    tr_list_s << getTdList(tds)
  }

  return tr_list_s
end

def getColumnWidthList(tr_list)
  if tr_list.empty?
    return nil
  end
  col_size = tr_list.first.size

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
      data = data.gsub("\n", '<br/>')
      result = result + data + " |"
    }
  }
  return result
end

# テーブルの解析
def parseTable(html)
  parse_result = html.gsub(/<table(.*?)>(.*?)<tbody>(.*?)<\/tbody>(.*?)<\/table>/m){|matched|
    table = matched # <tr><td>...</td></tr>...</tr>
    tr_list = getTrList(table)

    if tr_list.empty?
      table
    else
      col_width_list = getColumnWidthList(tr_list)

      body = tr_list

      result = "\n\n" + makeTableHead(col_width_list)
      result = result + "\n" + makeTableBody(tr_list, col_width_list) + "\n"

      result
    end
  }
  return parse_result
end

# コードブロックの文字修飾
# MarkDownにはないcpprefjpの独自記法
#
# 記述例：
# ```cpp
# int main()
# {
#     int value = 0;
# }
# ```
# value[color ff0000]
#
# 記述ルール：
# コードブロック終了直後の行から空行までを、直前のコードブロックへの修飾とする。
#
# 構文：
# name[attribute-name attribute-value(opt)]
#
# name : 修飾対象の名前。コードブロック内の特定文字列
# attribute-name : 属性名。リンク、文字色、書体等。
# attribute-value : 属性値。それぞれの属性に応じた値を入力する
#
# 定義可能な文字修飾：
# name[link http://...] : リンク修飾。nameに対して、属性値となるURLへのリンクを貼る
# name[color ff0000] ： 文字色修飾。nameに対して、属性値で指定された色を付ける。RGBの順に16進数2桁で指定する。
# name[italic] : 文字を斜体にする。
def codeBlockQualify(html)
  html = html.gsub(/<codeblock>(.*?)<\/codeblock>/m) {
    qualify_list = Array.new
    codeblock = $1
    codeblock = codeblock.gsub(/\[(.*?)\]\((.*?)\)/) {|matched|
      if matched.index('/') == nil
        matched
      else
        if qualify_list.select{|x| x['name'] == $1 && x['link'] != nil } == []
          qualify_list << {'name' => $1, 'link' => $2}
        end
        $1
      end
    }
    codeblock = codeblock.gsub(/<color=(.*?)>(.*?)<\/color>/) {
      if qualify_list.select{|x| x['name'] == $1 && x['color'] != nil } == []
        qualify_list << {'name' => $2, 'color' => $1}
      end
      $2
    }
    codeblock = codeblock.gsub(/<i>(.*?)<\/i>/) {
      if qualify_list.select{|x| x['name'] == $1 && x['italic'] != nil } == []
        qualify_list << {'name' => $1, 'italic' => true}
      end
      $1
    }

    codeblock = '<codeblock>' + codeblock + '</codeblock>' + "\n"
    qualify_list.each {|qualify|
      qualify_str = qualify['name']
      
      if qualify['link']
        qualify_str = qualify_str + '[link ' + qualify['link'] + ']'
      end

      if qualify['color']
        qualify_str = qualify_str + '[color ' + qualify['color'] + ']'
      end

      if qualify['italic']
         qualify_str = qualify_str + '[italic]'
      end
      qualify_str = '* ' + qualify_str + "\n"
      codeblock = codeblock + qualify_str
    }
    codeblock
  }

end

# コードブロックの解析
def parseCodeBlock(html)
  # コードブロックの開始
  html = html.gsub('<div class=\'sites-codeblock sites-codesnippet-block\'>', '<codeblock>')

  # コードの前後にある空行削除
  html = html.gsub(/<codeblock>\n*/, "<codeblock>\n")

  # コードブロックの終了
  html = html.gsub(/<codeblock>(.*?\n)\n+(?=\n)/m, "<codeblock>\\1</codeblock>")
  html = html.gsub(/<codeblock>(.*?)<\/codeblock>/m) {|matched|
    if $1.index('##')
      matched.sub(/<codeblock>(.*?)##/m, "<codeblock>\\1</codeblock>\n##")
    else
      matched
    end
  }

  # コードブロック内のゴミ消し
  html = html.gsub(/<codeblock>(.*?)<\/codeblock>/m) {|codeblock|
    codeblock = codeblock.gsub('<code>', '').gsub('</code>', '')
  }

  html = codeBlockQualify(html)
  
  # バッククォートでコードブロック
  html = html.gsub(/<codeblock>/, '```cpp')
  html = html.gsub(/<\/codeblock>/, '```')
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

  html = html.gsub(/<span style=\'background-color:(.*?)\'>(.*?)<\/span>/m, '<backcolor:\1>\2</backcolor>')
  html = html.gsub(/<span(.*?)>(.*?)<\/span>/, '\2')
  html = html.gsub(/<backcolor:(.*?)>(.*?)<\/backcolor>/m, "<span style=\'background-color:\\1\'>\\2<\/span>")

  return html
end

# 画像埋め込みのパース
def parseImage(html)
  html = html.gsub(/<a rel='nofollow' imageanchor='1' href='(.*?)'>(.*?)<\/a>/, '\2')
  html = html.gsub(/<img src='(.*?)' border='0'\/>/, '![](\1)')
  return html
end

# 差分階層を作る
def makeSubHierarchy(a, b)
  b.size.times {|i|
    if a[i] != b[i]
      return a
    end
  }
  return a[b.size - 1, a.size - b.size + 1]
end

# URLをサイト内リンクに変換
def convertLink(html, path)
  path = path.gsub(/html\/(.*?).html/, '\1') # サイト内絶対パスの形式を合わせる
  path_hierarchy = path.split('/')

  return html.gsub(/href='https:\/\/sites.google.com\/site\/cpprefjp\/(.*?)'/) {
    link = $1
    link_hierarchy = link.split('/')

    sub_hierarchy = makeSubHierarchy(link_hierarchy, path_hierarchy)

    new_link = if sub_hierarchy.size == link_hierarchy.size
                 '/' + link # サイト内絶対パス
               else
                 './' + sub_hierarchy.join('/') # サイト内相対パス
               end

    new_link = new_link + ".md"
    "href='" + new_link + "'"
  }
end

def htmlToMarkdown(html_path, markdown_path)
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

  # タイトル
  html = html.gsub(/<title>(.*?)<\/title>/, '#\1')

  # 見出し
  html = html.gsub(/<h2(.*?)>(.*?)<\/h2>/, "\n\n##\\2\n")
  html = html.gsub(/<h3><\/h3>/, '')
  html = html.gsub(/<h3(.*?)>(.*?)<\/h3>/, "\n\n###\\2\n")

  # 箇条書き
  html = html.gsub(/<li>(.*?)<\/li>/, "\n- \\1")
  html = html.gsub('<ul>', "")
  html = html.gsub('</ul>', "")

  # 画像埋め込み
  html = parseImage(html)

  # リンク
  html = convertLink(html, html_path)
  html = html.gsub(/<a(.*?) href=\'(.*?)\'>(.*?)<\/a>/, '[\3](\2)')

  # コードブロック
  html = parseCodeBlock(html)

  # コード
  html = html.gsub(/<code>(.*?)<\/code>/) {
    if $1.index('&#') == nil
      '`' + $1 + '`'
    else
      '<code>' + $1 + '</code>'
    end
  }
  html = html.gsub(/`\[(.*?)\]\((.*?)\)`/, '[`\1`](\2)')

  # ゴミ消し
  html = deleteAfterTrash(html)

  FileUtils.makedirs(File.dirname(markdown_path))
  File.open(markdown_path, 'w') {|f|
    f.write(html)
  }

  #puts html
end

def enumerateRecursiveDir(path)
  Dir::foreach(path) {|f|
    next if f == '.' or  f == '..'
    if path =~ /\/$/
      f = path + f
    else
      f = path + '/' + f
    end
    if FileTest::directory?(f)
      enumerateRecursiveDir(f) {|nested_file|
        yield nested_file
      }
    else
      yield f
    end
  }
end

#htmlToMarkdown('advance.html', 'advance.md')
#htmlToMarkdown('fetch_add.html', 'fetch_add.md')
#htmlToMarkdown('atomic.html', 'atomic.md')
#htmlToMarkdown('iterator.html', 'iterator.md')
#htmlToMarkdown('reference.html', 'reference.md')

enumerateRecursiveDir('html') {|html_path|
  markdown_path = html_path.sub(/html(.*?).html/) {
    'markdown' + $1 + '.md'
  }

  htmlToMarkdown(html_path, markdown_path)
}

