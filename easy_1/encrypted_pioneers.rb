Encrypted Pioneers
The following list contains the names of individuals who are pioneers in the field of computing
or that have had a significant influence on the field.
The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption called Rot13.
Write a program that deciphers and prints each of these names .

-----
My Solutions: non-OOP & OOP 

pioneer_list = <<-LIST.split("\n")
Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu
  LIST

# Non-OOP solution: 
def decrypt(string)
  hash = {}
  (97..97+12).each {|n| hash[n.chr] = (n+13).chr} # non-capitalized letters  
  (65..65+12).each {|n| hash[n.chr] = (n+13).chr} # capitalized letters
  hash.merge!(hash.invert)
  puts string.split('').each_with_object('') { |n, answer| answer << hash.fetch(n, n) }
end

pioneer_list.each {|name| decrypt(name) } 

# OOP solution: 
class Decrypter 
  def initialize(names_list) 
    @decrypter = generate_decrypter.freeze 
    @encrypted_list = names_list
    @decrypted_list = []
  end 

  def generate_decrypter 
    hash = {}
    (97..97+12).each {|n| hash[n.chr] = (n+13).chr} # non-capitalized   
    (65..65+12).each {|n| hash[n.chr] = (n+13).chr} # capitalized 
    hash.merge!(hash.invert)
  end

  def decrypt 
    @encrypted_list.each do |name| 
      @decrypted_list << name.split('').reduce('') do |name, char| 
         name + @decrypter.fetch(char, char)
      end 
    end 
  end 

  def print_decrypted
    puts @decrypted_list
  end 
end 

list = Decrypter.new(pioneer_list)
list.decrypt
list.print_decrypted

-----
Student solutions: Using String#tr is an obvious solution

NAMES = [
    'Nqn Ybirynpr',
    'Tenpr Ubccre',
    'Nqryr Tbyqfgvar',
    'Nyna Ghevat',
    'Puneyrf Onoontr',
    'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
    'Wbua Ngnanfbss',
    'Ybvf Unvog',
    'Pynhqr Funaaba',
    'Fgrir Wbof',
    'Ovyy Tngrf',
    'Gvz Orearef-Yrr',
    'Fgrir Jbmavnx',
    'Xbaenq Mhfr',
    'Fve Nagbal Ubner',
    'Zneiva Zvafxl',
    'Lhxvuveb Zngfhzbgb',
    'Unllvz Fybavzfxv',
    'Tregehqr Oynapu',
].freeze

NAMES.each do |name|
  puts name.tr('a-zA-Z','n-za-mN-ZA-M')
end


------
LS Solution: Not as direct 

ENCRYPTED_PIONEERS = [
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
].freeze

def rot13(encrypted_text)
  encrypted_text.each_char.reduce('') do |result, encrypted_char|
    result + decipher_character(encrypted_char)
  end
end

def decipher_character(encrypted_char)
  case encrypted_char
  when 'a'..'m', 'A'..'M' then (encrypted_char.ord + 13).chr
  when 'n'..'z', 'N'..'Z' then (encrypted_char.ord - 13).chr
  else                         encrypted_char
  end
end

ENCRYPTED_PIONEERS.each do |encrypted_name|
  puts rot13(encrypted_name)
end

Discussion: 

It's tempting to use a lookup table with a hash to solve this problem, 
but it's actually easier to use the description of Rot13 directly ("rotate" each character by 13), so that's what we will do.

Our program begins by setting up a constant Array that contains our encrypted list of pioneers.

We will use a method, rot13, to decrypt each name in the list, one at a time, 
and within that method, we use decipher_character to decrypt each character. 
We use String#each_char and Enumerable#reduce to iterate through the characters in encrypted_text, 
and construct the decrypted return value.

decipher_character uses a case statement that breaks the character decryption problem into 3 parts: 
the letters between A and M, the letters between N and Z, and everything else. 
Note that we check for both uppercase and lowercase letters because that's what we have to deal with. 

The first group is easy: we can shift the character 13 places forward ('A' becomes 'N', 'B' becomes 'O', ..., 'M' becomes 'Z'). 
We do this with String#ord and Integer#chr which convert a character to a numeric value and vice versa. 
Similarly, we do the same for the 2nd group, 
but this time we need to shift letters to the left by 13 places ('N' becomes 'A', 'O' becomes 'B', etc). 
Lastly, we can handle everything else by returning the value unchanged.

Once we have all the components in place, all we have to do is iterate through our list of encrypted names, and print each decrypted name.