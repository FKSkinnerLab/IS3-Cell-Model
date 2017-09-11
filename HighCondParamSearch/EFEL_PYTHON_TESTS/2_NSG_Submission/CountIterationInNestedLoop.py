count = 0
index = -1
for i in range(0,10):
	for j in range(0,20):
		for k in range(0,5):
			for l in range(0,7):
				prev_index = index
				index = l + k*len(range(0,7)) + j*len(range(0,5))*len(range(0,7)) + i*len(range(0,20))*len(range(0,5))*len(range(0,7))
				diff = index - prev_index
				if diff != 1:
					print(diff)
					print(l + k*len(range(0,7)) + j*len(range(0,5))*len(range(0,7)) + i*len(range(0,20))*len(range(0,5))*len(range(0,7)))
				count = count + 1

