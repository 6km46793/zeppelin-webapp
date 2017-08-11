%python

# print('hello zeppelin')

print(z.input('input form'))

print(z.select('select form', [(str(item), 'app' + str(item)) for item in range(1,11)], '2'))

print(z.checkbox('checkbox form', [(str(item), 'app' + str(item)) for item in range(1,11)], [str(i) for i in range(1,5)]))
