#Implement all parts of this assignment within (this) module2_assignment2.rb file

class LineAnalyzer
  attr_reader :highest_wf_count
  attr_reader :highest_wf_words
  attr_reader :content
  attr_reader :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency()
  end

  def calculate_word_frequency()
    @highest_wf_count = 0
    @highest_wf_words = []
    @content.split(' ').uniq.each do |word|
      regex = /\b#{word}\b/i
      if @highest_wf_count < @content.scan(regex).count
        @highest_wf_words.clear
        @highest_wf_words << word
        @highest_wf_count = @content.scan(regex).count
      elsif @highest_wf_count == @content.scan(regex).count
        @highest_wf_words << word
      end
    end
  end
end

class Solution
  attr_reader :analyzers
  attr_reader :highest_count_across_lines
  attr_reader :highest_count_words_across_lines
  
  def initialize()
    @analyzers = []
  end

  def analyze_file()
    @line_count = 0
    File.foreach('test.txt') do |line|
      @line_count += 1
      @analyzers << LineAnalyzer.new(line.downcase, @line_count)
    end
  end
  
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @analyzers.each do |analyzer|
      if @highest_count_across_lines < analyzer.highest_wf_count
        @highest_count_words_across_lines = Array.new
        @highest_count_words_across_lines << analyzer
        @highest_count_across_lines = analyzer.highest_wf_count
      elsif @highest_count_across_lines == analyzer.highest_wf_count
        @highest_count_words_across_lines << analyzer
      end
    end
  end
  
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each { |analyzer| puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})" }
  end
end
