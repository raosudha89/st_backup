import sys

input_file = open(sys.argv[1], 'r')
model_name = sys.argv[2]
output_file = open(sys.argv[3], 'w')
i = 1
for line in input_file.readlines():
	output_file.write('%s_%s\t%s' % (i, model_name, line))
	i += 1
