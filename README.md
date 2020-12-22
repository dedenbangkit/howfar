# HOWFAR
Maps direction on your terminal

## Requrements
Please make sure that you are using **Zsh** instead of bash `zsh --version`. **Zsh** is a powerful shell that operates as both an interactive shell and as a scripting language interpreter. While being compatible with the POSIX sh (not by default, only if issuing emulate sh), it offers advantages such as improved tab completion and globbing.

## Dependency (jq)
- [jq](https://github.com/stedolan/jq) a lightweight and flexible command-line JSON processor.

## Installation

```zsh
$ git clone https://github.com/dedenbangkit/howfar
$ source howfar.zsh or
$ cat howfar.zsh >> ~/.zshrc #or any config file
$ echo 'export GOOGLE_MAP_APIKEY="<your_google_map_api_key>"' >> ~/.zshrc #or any environment config file
```

## Usage
```zsh
$ howfar villa gardenia yogyakarta to candi borobudur

 ORIGIN : Sempu, Bangunjiwo, Kec. Kasihan, Bantul, Daerah Istimewa Yogyakarta 55184, Indonesia
 DESTINATION : Jl. Badrawati, Kw. Candi Borobudur, Borobudur, Kec. Borobudur, Magelang, Jawa Tengah, Indonesia
 DISTANCE : 42.5 km
 DURATION : 1 hour 11 mins


 DISTANCE   DURATION    INSTRUCTIONS

 0.1 km      1 min       Head northwest
 15 m        1 min       Continue straight
 0.2 km      1 min       Turn left onto Jl. Ratu Boko
 18 m        1 min       Turn right
 0.3 km      1 min       Continue straight
 0.5 km      1 min       Turn left onto Gg. Yudistira
 0.5 km      1 min       Turn right onto Jl. Karangjati
 35 m        1 min       Turn right onto Jl. Bibis Raya
 0.7 km      2 mins      Turn left onto Jl. Tj. Raya
 0.7 km      1 min       Slight left onto Jl. Ring Road Selatan
 1.7 km      2 mins      Keep right to continue on Jl. Nasional III Pass by BPS Special Region of Yogyakarta
 1.7 km      3 mins      Turn left to stay on Jl. Nasional III Pass by Honda Daya Motor Gamping
 1.6 km      3 mins      Turn right after Indomaret Nyamplung
 1.6 km      3 mins      Turn left onto Jl. Bibis
                         –– Jl. Pirak - Pathukan
 1.5 km      3 mins      Turn right onto Jl. Sembuh Wetan
 4.9 km      9 mins      Turn left onto Jl. Godean
                         –– Jl. Ngapak - Kentheng Continue to follow Jl. Ngapak - Kentheng Pass by Agen Wahana Express Sidoluhur Godean
 1.5 km      2 mins      Turn right onto Jl. Gedongan-Tempel
 1.9 km      3 mins      Turn left onto Jl. Daratan 3
 0.4 km      1 min       Turn right
 1.7 km      2 mins      Turn left
 56 m        1 min       Turn left onto Jl. Kebon Agung
 1.6 km      3 mins      Turn right onto Jl. Raya Banjararum
 10.9 km     14 mins     Turn right onto Jl. Dekso Kepiton
                         –– Jl. Nanggulan Mendut Continue to follow Jl. Nanggulan Mendut
 6.1 km      10 mins     Turn left onto Jl. Alternative Nanggulan - Borobudur
 0.9 km      1 min       Turn left onto Jl. Wanurejo
 0.2 km      1 min       Turn left onto Jl. Balaputradewa
 0.3 km      1 min       At ATM Mandiri, Jl. Balaputradewa turns left and becomes Jl. Badrawati
 75 m        1 min       Turn right Partial restricted usage road
 0.4 km      1 min       Keep left
 0.3 km      1 min       Sharp right at Jl. Borobudur Tram Ride Destination will be on the left

```

## Read More

1. [**Google Maps Platform**](https://developers.google.com/maps/gmp-get-started) allows you to query locations for any Google Maps data. The Google Maps Platform is a set of APIs and SDKs that allows developers to embed Google Maps into mobile apps and web pages, or to retrieve data from Google Maps. There are several offerings. Depending on your needs, you may find yourself using one or a combination of these APIs and SDKs.
2. [**sed**](https://www.gnu.org/software/sed/manual/sed.html) is a stream editor. A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline). While in some ways similar to an editor which permits scripted edits (such as ed), sed works by making only one pass over the input(s), and is consequently more efficient. But it is sed’s ability to filter text in a pipeline which particularly distinguishes it from other types of editors.
3. [**jq**](https://stedolan.github.io/jq/) is like sed for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.
4. [What is ZSH, and Why Should You Use It Instead of Bash?](https://www.howtogeek.com/362409/what-is-zsh-and-why-should-you-use-it-instead-of-bash/#:~:text=ZSH%2C%20also%20called%20the%20Z,switching%20over%20is%20a%20breeze.)

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).
