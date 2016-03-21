# Class: localusers
#

#
class localusers {
	# resources
	user { 'hamza':
	  comment    => 'Admin guy',
	  home       => '/home/hamza',
	  ensure     => present,
	  groups     => 'sudo',
	  shell      => '/bin/bash',
	  managehome => true,
	}

	ssh_authorized_key {'secret-key':
	  user   => 'hamza',
	  ensure => present,
	  type   => 'ssh-rsa',
	  key    => 'MIIEpAIBAAKCAQEAxDPGsz8MWq5ZVHwlY5TekmIdneMKGa5oE8sazAzchvYsjhWgNRA5Nvqfpm6pCFhXs54Uxxbo0/uF2u78lvxbAuBNWaXNFZeT7I1wMyHaW9uSKZ7ZJZIhmsA2Ohq7yZMSpjw5SkbbhmjtutdlmZYlWoyaWZs/MERLWmtbZ5RxCcOiJEI8h6dgx2H+lKKa55sZ0q+MSODQVngyYmPrJLUHlMWuC8bcfmC1G1VpHNQ9x8O3cEfHjfYGeZUtLN/mFheW5Lef7jXQ+Qy87tWqYSTzhQexB7i8c3as+UjPMWCU3v6OpcjJzrYY9qDHu/4G5RxCPLTZg7YrEwgZFH0Wjh9tawIDAQABAoIBAQCayh5hG8SrZhGjza3Ruok+A5pKDezSBf6mXv5tLVhuQZk1H2qdcocxENkTfQpuQwQt+PF7gF9/nlgkOZedpspGop9jsqLx/fv+DDgQnwyem8Pcgi3erkNEy4/8l0q/5QA5lhm8t9pJWE71sSm+2e3uWi8LsqdPdRHd7ATY2wuzHvqh67lLXbV1eqVp9LQdfBx5s0HvioYhjNhLoyiQwyPm2aQuAwCFJSQJTKjW45fy2pB6Uk2iCDp++iYixV0wMvAbw3YyvUYoqgw/sZemondIGIAMLJvd0VZiBnsJ1/d9wfMLDSo+0fciIGnKOpHB3WFPLxnpl1zF0k7znojKyOjBAoGBAOulqBz62d6pwZMENSWc8O0TW8pSRO61G7nrbHLvxZQAXp482wJnP4exfXanqTobssazT/QNq9gNA+6DWBzmaz0EjNH+pp2ueKEf/lWa7QtKktT2hrMuuBHrWUUpBKVAVfTdDDVJwJfp2MFcUHBA9miFVW4PfZne8Nvy1+BLA9sHAoGBANUl9nphZSGwYanZGgJfOKR/34YPGwBtQlu+uRo7c+JwQDBy3xrQAF/YReTkukovjylG9LJ8BcCW2RJ4/aBH9B9/Lxy6qafLeAAw7SjYd9kfzMsXRbjjPQUxXNaEpAUPYbv7hAfD1sbcvI7lieFIxYrow7UBqYsT7pNBB2xSyO19AoGANQvgkU2C+BXcxpye3i27KpM+CYiFjfrlF/BARItnPc7rfdGTN7JIYeJ5rNlHRhZwIzzAVd8x/PvJE8srba4NG/pHPQqHNV3ON+880MaEcBNEhH5Oik2NEDObr+7w5cZa0zljgydsHIZ+zeBbFzn4fkTtm04PZzEBpXHAWPRqFMcCgYAIf5P9OybiGfs632oXEB7dCDAsUyvbb3/G0qrkrdwn+hvFEr9sfUCWkbPvtWLsFEtb9PVKrIE6NYmAIAzUuCm2m8aQGa0sAIPPViQOjdrxcEAlFM912LGVJGu0LeOwQ/W8ngGcoaVNln16IRLHRbSCnlc3P1K4Ndo8Ssp1+jMCrQKBgQDRVqTykqaZa0Z28xGumnh66BOBdoDCU9jz/UZDSnxIpYy+BuoUPB9IuxRov5IOKV/o9N/oKrVIIjz/DDmolif3z6sUwPtExTumoTdqjzPKJ51MZ3AGLNlHDtvfE6pxEDzQDZ2OljeG1uJWxI0hU7y0QnRp9GX0XZp2gZCiIWNX9g=='
	}


}