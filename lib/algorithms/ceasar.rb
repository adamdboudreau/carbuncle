class Ceasar
  KEY = 3
  ALPHABET =  ["a", "b", "c", "d", "e", "f", "g", "h", 
              "i", "j", "k", "l", "m", "n", "0", "p", "q", 
              "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  LEN = 26

  def encrypt(message)
    mess = ""

    message.each_char do |c|
      i = ALPHABET.index c.downcase
      
      if i.nil?
        mess << c
      else
        newIndex = i + KEY
        newIndex -= 26 if newIndex > 25
        mess << ALPHABET[newIndex]
      end
    end

    mess
  end

  def decrypt(message)
    mess = ""

    message.each_char do |c|
      i = ALPHABET.index c.downcase
      
      if i.nil?
        mess << c
      else
        newIndex = i - KEY
        newIndex += 26 if newIndex < 0
        mess << ALPHABET[newIndex]
      end
    end

    mess
  end
end

c = Ceasar.new
original = "ABCDEFG_HIJK LMN0PQRSTUVW\n\rXYZ"
p "Encrypting: " + original
encrypted = c.encrypt original
p "Encrypted: " + encrypted
decrypted = c.decrypt encrypted
p "Decrypted: " + decrypted
p "Original : " + original
