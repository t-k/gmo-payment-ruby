require 'kconv'

class String
  @encoding = nil

  def encoding
    if @encoding != nil then
      return @encoding
    else
      case Kconv.guess(self)
      when Kconv::JIS
        return "ISO-2022-JP"
      when Kconv::SJIS
        return "Shift_JIS"
      when Kconv::EUC
        return "EUC-JP"
      when Kconv::ASCII
        return "ASCII"
      when Kconv::UTF8
        return "UTF-8"
      when Kconv::UTF16
        return "UTF-16BE"
      when Kconv::UNKNOWN
        return nil
      when Kconv::BINARY
        return nil
      else
        return nil
      end
    end
  end

end