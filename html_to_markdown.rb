#!/usr/bin/ruby
# -*- coding: utf-8 -*- 

require 'cgi'

def htmlToMarkdown(html_path)
  filename = File.basename(html_path, ".html")

  html = File.open(html_path).read

  # 参照文字をデコード
  html = CGI.unescapeHTML(html)

  html = html.gsub('<table class=\'sites-layout-name-one-column sites-layout-hbox\' cellspacing=\'0\'><tbody><tr><td class=\'sites-layout-tile sites-tile-name-content-1\'><div dir=\'ltr\'>', "")
  html = html.gsub("<div>", "")
  html = html.gsub("</div>", "\n")

  # 意味がないので削除
  html = html.gsub(/<font face=\'monospace\' color=\'#000000\'>(.*?)<\/font>/, '\1')
  html = html.gsub(/<font face=\'monospace\' color=\'#000000\'>(.*?)\n<\/font>/, '\1')
  html = html.gsub(/<font face=\'monospace\'>((\n|.)*?)<\/font>/, '\1')
  html = html.gsub(/<div style=\'color:rgb\(0,0,0\)\'>/, "")

  # ゴミ消し
  html = html.gsub('<font face=\'monospace\' color=\'#000000\'>', "")
  html = html.gsub('<font color=\'#000000\'>', "")

  html = html.gsub("<br/>", "")
  html = html.gsub(/<a name=(.*?)>/, "")

  # 文字色
  html = html.gsub(/<font color=\'#ff0000\'>(.*?)<\/font>/, '<color=000000>\1</color>')
  html = html.gsub(/<font color=\'#000000\'>(.*?)<\/font>/, '\1') # 意味がないので無視
  html = html.gsub('</font>', '') # 消し残し

  # コードブロックの開始
  html = html.gsub('<div class=\'sites-codeblock sites-codesnippet-block\'>', '<codeblock>')

  # コードの前後にある空行削除
  html = html.gsub(/<codeblock>\n*/, "<codeblock>\n")

  # コードブロックの終了
  #html = html.gsub(/<codeblock>((\n|.)*?\n{3,})?/m, "<codeblock>\\1</codeblock>\n")
  #html = html.gsub(/^\n{3,}<\/codeblock>/m, "</codeblock>")
  html = html.gsub(/<codeblock>(.*?\n)\n+(?=\n)/m, "<codeblock>\\1</codeblock>")

  # 最終行を削除
  html = html.gsub("\n</td></tr></tbody></table>", "")

  File.open("#{filename}.txt", "w") {|f|
    f.write(html)
  }

  #puts html
end

htmlToMarkdown('advance.html')
htmlToMarkdown('fetch_add.html')
