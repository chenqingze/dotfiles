dotfiles
===================

***NOTE*** Refer: https://www.chezmoi.io

[For MacOS] 

1. Clone this repo into your machine:  

```
git clone --depth 1 git@github.com:chenqingze/dotfiles.git [~/your_dotfiles_path]
```

***NOTE*** Remember edit dot_gitconfig file with your own git infomation

2. apply dotfile 

```
cd ~/your_dotfiles_path && sh ./bootstrap.sh
```
or
```
cd ~/your_dotfiles_path && chmod +x bootstrap.sh && ./bootstrap.sh
```

Update
------

From time to time you should pull down any updates to these dotfiles, and run

```
chezmoi update
```


