
class String
  def is_i?
    /\A\d+\z/ === self.strip
  end

  def colorize(color)
    "#{color}#{"%2s" % self}#{Colors::DEFAULT}"
  end

  def red
    colorize(Colors::RED)
  end

  def green
    colorize(Colors::GREEN)
  end

  def yellow
    colorize(Colors::YELLOW)
  end

  def blue
    colorize(Colors::BLUE)
  end

  def cyan
    colorize(Colors::CYAN)
  end


  class Colors
  	RED = "\033[1;31m"
  	GREEN = "\033[1;32m"
  	YELLOW = "\033[1;33m"
  	BLUE = "\033[1;34m"
    CYAN = "\033[1;36m"
  	DEFAULT = "\033[0m"
  end
  private_constant :Colors
end