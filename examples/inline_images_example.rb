#!/usr/bin/env ruby
# Use the local version of Caracal instead of the installed gem
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require_relative '../lib/caracal'

# Create a new Caracal document
docx = Caracal::Document.new('inline_images_example.docx')

# Add a title
docx.h1 'Inline Images Example'

# Add a paragraph with text only
docx.p 'This is a paragraph with text only.'

# Add a paragraph with an image on a new line (standard Caracal behavior)
docx.img 'https://via.placeholder.com/150', width: 150, height: 150

# Add a paragraph with text and inline images
docx.p do
  text 'This paragraph has text and '
  img 'https://via.placeholder.com/100', width: 100, height: 100
  text ' an inline image in the middle of the text.'
end

# Add a paragraph with multiple inline images
docx.p do
  text 'Here are two images side by side: '
  img 'https://via.placeholder.com/80', width: 80, height: 80
  img 'https://via.placeholder.com/80', width: 80, height: 80
  text ' with text after them.'
end

# Add a paragraph with text between inline images
docx.p do
  text 'First image: '
  img 'https://via.placeholder.com/50', width: 50, height: 50
  text ' text between images '
  img 'https://via.placeholder.com/50', width: 50, height: 50
  text ' more text after images.'
end

# Save the document
docx.save
puts "Document saved as 'inline_images_example.docx'"
