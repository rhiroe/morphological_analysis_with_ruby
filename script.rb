require 'natto'

output_file = File.open('wakachi.txt', 'a')
nm = Natto::MeCab.new

text = `cat jawiki.txt`

text.each_line do |sentence|
  words = []
  nm.parse(sentence) do |n|
    next if n.is_eos? || %w[動詞 名詞].none?(&n.feature.method(:start_with?))

    words << n.surface if n.is_nor?
  end
  output_file.puts words.join(' ')
end

require 'fasttext'

model = FastText::Vectorizer.new
model.fit('wakachi.txt')
