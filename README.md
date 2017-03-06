# IPv6 binary to hex ruby code

Having basic understanding of what code can do has started to influence the way I see how some things can be handled differently. 

I am currently taking Business Data Communications and Networks. For one of the lab assignments that I had to do I kept thinking “this is tedious” “there has to be an automatic way to do this.” 

With Flatiron I have finished the section of Procedural Ruby and are working through the section of Object Oriented Ruby. Now I know that some methods exists that can be done with Ruby to solve this problem with code. A month ago I would of completed the lab assignment, probably complained a bit at how tedious the task was, but I would not have had the desire to seek out a solution using code. 

#### I will explain what had to be done.

The purpose was to learn how to represent IPv6 addresses in a more concise human-readable standard than IPv4. 
This is to convert an IPv6 address that is presented in binary to a hexadecimal format.
The way that IPv6 is represented is with 8 blocks of 4 hexadecimal digits separated by a colon. 


An example of an IPv6 address in binary is 
00100000 00000001 00001101 01110100 00111000 00101101 00000000 00010010 00000000 00000000 00000000 00000001 00010010 00110100  10101010 01010110

#### Step 1: convert to canonical text
In order to prevent errors from occurring while working with these addresses they are canonical text representation.

2001:0d74:382d:0012:0000:0001:56aa:1234

This is much better but we still went through a set or steps to decrease it’s length. 

#### Step 2: eliminate leading 3 0’s
All of the leasing 0s are eliminated, up to 3. If there is only a single group of all 0 digits, meaning four 0’s in a row only the first three 0’s could be eliminated and it would be “0” not “::. 

2001:0d74:382d:0012:~~000~~0:~~000~~1:56aa:1234 

Leaving with 2001:d74:382d:12:0:1:56aa:1234 

#### Step 3: Zero compression
There is an additional rule known as “zero compression” that eliminates consecutive groups of 4 hexadecimal digits when they are all 0’s.

This rule only applies to the first group of 0’s. If the address would have been 
2001:0d74:0000:0000:0000:0001:0000:0000 only the first set of 0’s is compressed and not the second one. 

For example if the previous canonical text representation was now
2001:0d74:0000:0000:0000:0001:56aa:1234

The consecutive 0’s would be compressed
2001:0d74:0000:0000:0000:0001:56aa:1234

Leaving 2001:d74::::1:56aa:1234

So our IPv6 address in binary 00100000 00000001 00001101 01110100 00111000 00101101 00000000 00010010 00000000 00000000 00000000 00000001 00010010 00110100  10101010 01010110 is represented as 2001:d74::::1:56aa:1234. 


These are not difficult steps to follow, but when several of these problems had to be solved by typing them on the screen I would have liked to simply put the binary address and *voila!* out comes the number in its represented form.  


## Now to the good part of using code to do this busy work

String that we will be using as an example. 

address_binary = "00100000 00000001 00001101 01110100 00111000 00101101 00000000
00010010 00000000 00000000 00000000 00000001 00010010 00110100  10101010 01010110"

### Converting the string of the IPv6 address to an array

`split_address = address_binary.split(" ")` 

This  will create a variable set to a string of the address in binary.

This string will then be split with the delimiter of a space (“ “).  Giving us an array of strings with 16 elements and each element represents 8 bits.

Output 

split_address
["00100000", "00000001", "00001101", "01110100", "00111000", "00101101", "00000000", "00010010", "00000000", "00000000", "00000000", "00000001", "00010010", "00110100", "10101010", "01010110"]


### Separating each element into 4, quad

```
split = split_address.collect do |quad| 
  [quad[0..3],quad[4..7]]
end
split = split.flatten
```

Then each of these elements needs to be split in half creating 4 character strings. It originally creates an array of arrays each with two elements. This will then be flatten to create a single array of strings. 

In this array each element represents a single character, a hexadecimal digit used in IPv6.

Output
quad
["0010", "0000", "0000", "0001", "0000", "1101", "0111", "0100", "0011", "1000", "0010", "1101", "0000", "0000", "0001", "0010", "0000", "0000", "0000", "0000", "0000", "0000", "0000", "0001", "0001", "0010", "0011", "0100", "1010", "1010", "0101", "0110"]

### Steps to convert string as a hexadecimal
This next step required further reading on the method to_i.  LINK 

The purpose of this is to convert the binary string to hexadecimal. 
In order to do this we have to perform two operations.

We take the string convert it to integer. 
string.to_i  example “1101” to 1101

This integer is interpreted to a number.   1101 = 13
We converted it back to a string as a hexadecimal. 

```
hex_characters= split.collect do |binary_string|
  binary_string.to_i(2).to_s(16)
end
```

Output
hex characters
["2", "0", "0", "1", "0", "d", "7", "4", "3", "8", "2", "d", "0", "0", "1", "2", "0", "0", "0", "0", "0", "0", "0", "1", "1", "2", "3", "4", "a", "a", "5", "6"]

From here we want to group these characters into an element of 4 characters. This is because the IPv6 representation follows this format. 

```
leading = hex_characters.each_slice(4).collect do |group_four|
  group_four.join
end
```

Output
grouping by 4
["2001", "0d74", "382d", "0012", "0000", "0001", "1234", "aa56"]


Step 2 in the described steps above says to remove all of the leading zeros. 

```
no_leading_zeros = leading.collect do |delete_leading|
  delete_leading.gsub(/^0{1,3}/, "")
end
```

Output
no leading 0s
"2001:d74:382d:12:0:1:1234:aa56"


This gives us the IPv6 address in binary from 00100000 00000001 00001101 01110100 00111000 00101101 00000000 00010010 00000000 00000000 00000000 00000001 00010010 00110100  10101010 01010110 to its hex representation of 2001:d74:382d:12:0:1:1234:aa56. 


Looking at 2001:d74:382d:12:0:1:1234:aa56 This makes it a lot easier on the eye. 

Step number 4 tells us to to remove any of the zeros in the hex representation. In this step we did not have to do any and the code is also not showing that step. (I will update the code in the future) It is a lot easier to remove the zeros when they are grouped together visually, and by clicking the delete key then interpreting into a canonical text. 


In the end, as a developing developer I am learning to try to write legible code. This is still taking a lot of time and it is a skill that I am trying to work on. So after getting my code to successfully run I went back to try to make the code a bit “neater”. Below you will see the result. 


```
no_leading_zeros = address_binary
  .split(" ")
  .collect{ |quad| [quad[0..3],quad[4..7]]  }
  .flatten
  .collect {|binary_string|  binary_string.to_i(2).to_s(16)}
  .each_slice(4).collect { |group_four| group_four.join }
  .collect {|delete_leading|  delete_leading.gsub(/^0{1,3}/, "")}.join(":")

puts no_leading_zeros
```


Have you ever had to do something manually that is tedious that you wanted to create something that would to it for you?

*latina developer*

Link to github repo.












