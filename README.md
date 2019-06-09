## Nubank Ruby

Get Nubank bills data using its public API.

### Usage

Execute `/path/to/this/repo ruby nubank.rb`.

The QR Code authentication workflow will begin.
> You have 45 seconds to read the generated QR Code. After that, the login process continues.

If it's all ok, then you'll see a list of available bills to get information from.
Choose the bill that you want (by number) and press enter.

Then a `.xlsx` will be created with the selected bill data.

### TODO

+ Verify the automatic login workflow
+ Use `refresh_token` after access_token expiration
