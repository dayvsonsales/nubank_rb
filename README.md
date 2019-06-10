## Nubank Ruby

Get your Nubank bills within the terminal, using its public API.

### Usage

Execute `/path/to/this/repo ruby nubank.rb`.

The QR Code authentication workflow will begin.
> You have 45 seconds to read the generated QR Code. After that, the login process continues.

If it's all ok, then you'll see a list of available bills to get information from. 
> Only _open_ and _overdue_ bills will be displayed, because future bills don't have a details link. 

Choose the bill that you want (by number) and press enter. 
Then a `.xlsx` will be created with the selected bill data.

### TODO

+ Refactor main code (mainly from step 6 to the end) and some other parts too.
+ Use `refresh_token` after access_token expiration.

### How to contribute?

If you want to include more functionality or suggest some change:

1. Fork this repo and create a branch on your fork for your new feature/change.
2. Write your new feature/change.
3. Submit your PR!

If you want, you can buy me a coffee too! ;)

[<img src="https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png">](https://www.buymeacoffee.com/danilobarion/)

### Contact

If you have any questions, feel free to send me a message!
