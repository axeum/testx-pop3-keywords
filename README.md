testx-pop3-keywords
=====

A library that extends testx with keywords for testing pop3 mail servers. This library is packaged as a npm package and published to npm.isd.ictu

## How does it work
From the directory of the art code install the package as follows:
```sh
npm install testx-pop3-keywords --save --registry=http://npm.isd.ictu
```

After installing the package add the keywords to your protractor config file as follows:

```
testx.addKeywords(require 'pop3-keywords')
```

## Keywords

| Keyword                | Argument name | Argument value  | Description | Supports repeating arguments |
| ---------------------- | ------------- | --------------- |------------ | ---------------------------- |
| check mail             |               |                 | retrieve all mails and regex check in the data |  |
|                        | hostname      | hostname of the pop3 server || No |
|                        | port          | pop3 port || No |
|                        | username      | username of the mail account || No |
|                        | password      | password of the mail account || No |
|                        | expect1       | expected text to find in the mails (regex) || Yes |
| delete mail            |               |                 | delete all mails in the mailbox |  |
|                        | hostname      | hostname of the pop3 server || No |
|                        | port          | pop3 port || No |
|                        | username      | username of the mail account || No |
|                        | password      | password of the mail account || No |