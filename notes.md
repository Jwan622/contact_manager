1) expect(person).not_to be_valid

2) phone_number.to_param   ..... why does it return a stirng? If you're finding this id and matching... shouldn't you be matching by a number since in the database it's a number? Shouldn't you do phone_number.to_param.to_i


3) phone_number.reload
