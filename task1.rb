dec = nil

puts "Enter your username to use gpg"

username = gets.chomp

while dec != "q" do
  puts "What do you want to do?(e - encrypt, d - decrypt, q - quit)"
  dec = gets.chomp

  case dec
    when "e" then 
      puts "Enter filename you want to encrypt"

      filename = gets.chomp
      
      wasSuccessful = system("gpg -e -r #{username} #{filename}")
      
      if wasSuccessful 
        puts "Successfully encrypted #{filename}"
      else
        puts "Such file doesn`t exist"
      end
    when "d"
      puts "Enter filename you want to decrypt"

      filename = gets.chomp

      wasSuccessful = system("gpg -d -o #{filename.slice(0, filename.length - 4)} #{filename}")

      if wasSuccessful
        puts "Successfully decrypted #{filename}"
      else 
        puts "Such file doesn`t exist"
      end
    when "q"
    else
      puts "Wrong input. Try again"
  end
end