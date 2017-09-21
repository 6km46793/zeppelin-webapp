%python

# print(z.input('input_form'))

print(z.input('input'))

print(z.input('date_date'))

print(z.input('datetime_datetime'))

print(z.input('time_time'))

print(z.select('select_form', [(str(item), 'select_form' + str(item)) for item in range(1,11)], '2'))

checkboxList = [(str(item), 'checkbox' + str(item)) for item in range(1,11)]
checkboxList.insert(0, ('all','全部'))
print(z.checkbox('checkbox', checkboxList, [str(i) for i in range(1,5)]))

checkboxDorpdownList =  [(str(item), 'checkbox' + str(item)) for item in range(1,11)]
checkboxDorpdownList.insert(0, ('all','全部'))
print(z.checkbox('checkbox_dropdown',checkboxDorpdownList, [str(i) for i in range(1,5)]))

zeppelinTableData = "%table\nindex\tvalue\n"
for d in range(1,13):
    zeppelinTableData += (('value' + str(d) + '\t' + str(d) + '\n'))

print(zeppelinTableData)
