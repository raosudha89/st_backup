import sys

fluency_human_with_refno = open(sys.argv[1], 'r')
fluency_pred_ref0 = open(sys.argv[2], 'r').readlines()
fluency_pred_ref1 = open(sys.argv[3], 'r').readlines()
fluency_pred_ref2 = open(sys.argv[4], 'r').readlines()
fluency_pred_ref3 = open(sys.argv[5], 'r').readlines()
fluency_pred_ref0_1_2_3 = open(sys.argv[6], 'w')

i = 0
for line in fluency_human_with_refno.readlines():
	refno = line.split('\t')[0]
	if 'ref0' in refno:
		fluency_pred_ref0_1_2_3.write(fluency_pred_ref0[i])
	elif 'ref1' in refno:
		fluency_pred_ref0_1_2_3.write(fluency_pred_ref1[i])
	elif 'ref2' in refno:
		fluency_pred_ref0_1_2_3.write(fluency_pred_ref2[i])
	elif 'ref3' in refno:
		fluency_pred_ref0_1_2_3.write(fluency_pred_ref3[i])
	else:
		print 'Missing human pred. Defaulting to ref0'
		fluency_pred_ref0_1_2_3.write(fluency_pred_ref0[i])
	i += 1
