# coding: utf-8
module AlphabeticalPaginate
  class Language
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def russian?
      defined?(I18n) && I18n.locale == :ru && code == :ru
    end

    def german?
      defined?(I18n) && I18n.locale == :de && code == :de
    end

    def letters_regexp
      russian? ? /[а-яА-Я]/ : ( german? ? /[a-zA-ZäöüÄÖÜß]/ : /[a-zA-Z]/ )
    end

    def default_letter
      russian? ? "а" : "a" # First 'a' is russian, second - english
    end

    # used in view_helper
    def letters_range
      if russian?
        letters = []
        "АБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЭЮЯ".each_char{ |x| letters << x }
        letters
      elsif german?
        letters = []
        "AÄBCDEFGHIJKLMNOÖPQRSßTUÜVWXYZ".each_char{ |x| letters << x }
        letters
      else
        ('A'..'Z').to_a
      end
    end

    # used in view_helper
    def output_letter(l)
      (l == "All") ? all_field : l
    end

    # used in view_helper
    def all_field
      russian? ? 'Все' : (german? ? "Alle" : "All")
    end
  end
end
