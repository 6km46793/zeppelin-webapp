%python

# print('hello zeppelin')

z.input('input form')

z.select('select form', [(str(item), 'app' + str(item)) for item in range(1,11)], '2')

z.checkbox('checkbox form', [(str(item), 'app' + str(item)) for item in range(1,11)], [str(i) for i in range(1,5)])
