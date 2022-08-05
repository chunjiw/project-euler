package main

import (
	"fmt"
)

func main() {
	CL := Cletters()
	// fmt.Println(nletters(55, CL))
	// fmt.Println(nletters(67, CL))
	// fmt.Println(nletters(70, CL))
	// fmt.Println(nletters(342, CL))
	// fmt.Println(nletters(115, CL))
	// fmt.Println(nletters(100, CL))
	// fmt.Println(nletters(1115, CL))
	
	// for j := 21; j <= 99; j += 10 {
	// 	fmt.Println(nletters(j, CL))
	// }
	i := 1
	c := 0
	for i <= 1000 {
		c += nletters(i, CL)
		i += 1
	}
	fmt.Println(c)
}

func Cletters() []int {
	words := []string{"", "one", "two", "three", "four", "five", "six", "seven", "eight", 
		"nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", 
		"seventeen", "eighteen", "nineteen", "twenty"}
	CountLetters := make([]int, 21)
	for i, _ := range words {
		CountLetters[i] = len(words[i])
	}
	return CountLetters
}

func nletters(n int, CL []int) int {
	if n <= 20 {
		return CL[n]
	} else if n <= 99 {
		var a int
		if n/10 == 4 {
			a = 5
		 } else if n/10 == 2 {
			a = 6
		 } else {
			a = CL[10 + n/10] - 2
		 }
		return a + CL[n % 10]
	} else if n <= 999 {
		var b int
		if n % 100 == 0 {
			b = 0
		} else {
			b = 3
		}
		return CL[n/100] + len("hundred") + nletters(n % 100, CL) + b
	} else if n == 1000 {
		return 11
	} else {
		return 0
	}
}