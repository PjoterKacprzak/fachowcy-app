import 'package:email_validator/email_validator.dart';
import 'package:fachowcy_app/src/RegisterPage.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('empty name returns error string',(){
var result = NameValidator.validate('');
expect(result,'Błedny format');
  });

  test('too long name returns error',(){
var result = NameValidator.validate('jihksdfhijsdfhijfdsjihfdshijkjidfsjkdfsjkidsfjoikdsfjojofdsjfdsjkdfsjkjksfdjksdfjkdsfjkdsfjkjksdfjkdsfjkdsfjkjkfsdjkdf');
expect(result,'Błedny format');
  });

  test('digits in  name returns error',(){
var result = NameValidator.validate('45234234');
expect(result,'Błedny format');
  });

  test('specials in name returns error',(){
var result = NameValidator.validate('*');
expect(result,'Błedny format');
  });

  test('specials in name returns error',(){
var result = NameValidator.validate('/');
expect(result,'Błedny format');
  });


  //Last Name Input
  test('empty last name returns error string',(){
var result = LastNameValidator.validate('');
expect(result,'Błedny format');
  });

  test('too long last name returns error',(){
var result = LastNameValidator.validate('jihksdfhijsdfhijfdsjihfdshijkjidfsjkdfsjkidsfjoikdsfjojofdsjfdsjkdfsjkjksfdjksdfjkdsfjkdsfjkjksdfjkdsfjkdsfjkjkfsdjkdf');
expect(result,'Błedny format');
  });

  test('digits in last name returns error',(){
var result = LastNameValidator.validate('45234234');
expect(result,'Błedny format');
  });

  test('specials in last name returns error',(){
var result = LastNameValidator.validate('*');
expect(result,'Błedny format');
  });

  test('specials in last name returns error',(){
var result = LastNameValidator.validate('/');
expect(result,'Błedny format');
  });
  test('valid last name',(){
var result = LastNameValidator.validate('Test');
expect(result,null);
  });
  test('valid last name',(){
var result = LastNameValidator.validate('test');
expect(result,null);
  });
  test('valid last name',(){
var result = LastNameValidator.validate('sdfsdf');
expect(result,null);
  });


  //Telephone Input

  test('too long telephone returns error',(){
    var result = TelephoneValidator.validate('jihksdfhijsdfhijfdsjihfdshijkjidfsjkdfsjkidsfjoikdsfjojofdsjfdsjkdfsjkjksfdjksdfjkdsfjkdsfjkjksdfjkdsfjkdsfjkjkfsdjkdf');
    expect(result,'Błedny format');
  });
  test('too short telephone returns error',(){
    var result = TelephoneValidator.validate('2342342');
    expect(result,'Błedny format');
  });

  test('valid telephone number',(){
    var result = TelephoneValidator.validate('452342344545');
    expect(result,null);
  });

  test('specials in telephone returns error',(){
    var result = TelephoneValidator.validate('*');
    expect(result,'Błedny format');
  });

  test('specials in telephone returns error',(){
    var result = TelephoneValidator.validate('/');
    expect(result,'Błedny format');
  });

  //Password Input

  test('too long Password returns error',(){
    var result = PasswordValidator.validate('jihksdfhijsdfhijfdsjihfdshijkjidfsjkdfsjkidsfjoikdsfjojofdsjfdsjkdfsjkjksfdjksdfjkdsfjkdsfjkjksdfjkdsfjkdsfjkjkfsdjkdf');
    expect(result,'Błedny format');
  });
  test('too short Password returns error',(){
    var result = PasswordValidator.validate('s22');
    expect(result,'Błedny format');
  });

  test('valid Password ',(){
    var result = PasswordValidator.validate('Testing-1');
    expect(result,null);
  });
  test('valid Password ',(){
    var result = PasswordValidator.validate('Testing*1');
    expect(result,null);
  });
  test('valid Password ',(){
    var result = PasswordValidator.validate('Testing_1');
    expect(result,null);
  });
  test('too short Password ',(){
    var result = PasswordValidator.validate('Test_1');
    expect(result,'Błedny format');
  });
  test('specials in Password returns error',(){
    var result = PasswordValidator.validate('*');
    expect(result,'Błedny format');
  });

  test('specials in Password returns error',(){
    var result = TelephoneValidator.validate('/');
    expect(result,'Błedny format');
  });


  //Email Validator

  test('too long email returns error',(){
    var result = EmailValidator.validate('jihksdfhijsdfhijfdsjihfdshijkjidfsjkdfsjkidsfjoikdsfjojofdsjfdsjkdfsj@gmail.com');
    expect(result,false);
  });
  test('valid email ',(){
    var result = EmailValidator.validate('Test@gmail.com');
    expect(result,true);
  });
  test('valid email ',(){
    var result = EmailValidator.validate('Test@yahoo.com');
    expect(result,true);
  });
  test('valid email ',(){
    var result = EmailValidator.validate('test@o2.pl');
    expect(result,true);
  });

  test('valid email ',(){
    var result = EmailValidator.validate('test@wp.pl');
    expect(result,true);
  });

  test('valid email ',(){
    var result = EmailValidator.validate('test@onet.pl');
    expect(result,true);
  });


}