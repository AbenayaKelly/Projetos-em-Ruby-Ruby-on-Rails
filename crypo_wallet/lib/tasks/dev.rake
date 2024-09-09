namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop)}
      show_spinner( "Criando BD..") { %x(rails db:create)}
      show_spinner( "Migrando BD..") { %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não esta na tela de Desenvolvimento"
    end
  end

  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner( " Cadastrando moedas...")do
        coins =[
              {description: "BitCoin",
               acronym: "BTC",
               url_image: "https://static.vecteezy.com/system/resources/previews/008/854/653/non_2x/coin-cryptocurrency-bitcoin-free-png.png",
               mining_type: MiningType.find_by(acronym: "PoW")
              },
              {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://gallery.yopriceville.com/var/albums/Free-Clipart-Pictures/Money.PNG/Ethereum_ETH_Cryptocurrency_PNG_Clip_Art_Image.png?m=1529493509",
                mining_type: MiningType.all.sample
              },
              {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://www.goldeneaglecoin.com/resource/productimages/1oz-crypto-dash-silver-obv.png",
                mining_type: MiningType.all.sample
              },
              {
                description: "Iota",
                acronym: "IOT",
                url_image: "https://w7.pngwing.com/pngs/731/321/png-transparent-iota-coin-sign-icon-shiny-luxury-golden-design.png",
                mining_type: MiningType.all.sample
              },
              {
                description: "ZCash",
                acronym: "ZEC",
                url_image: "https://toppng.com/uploads/preview/zcash-zec-cryptocurrency-1154707682730zls7mgl7.png",
                mining_type: MiningType.all.sample
        }
            ]
            coins.each do |coin|
              sleep(1)
              Coin.find_or_create_by!(coin)
            end
    end

    end
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner( " Cadastrando tipos de  mineração...")do
      mining_types = [
        {description:"Proof of Work", acronym:"PoW"},
        {description:"Proof of Stake", acronym:"PoS"},
        {description:"Proof of Capacity", acronym:"PoC"}
      ]
      mining_types.each do |mining_type|
        sleep(1)
        MiningType.find_or_create_by!(mining_type)
      end
      end
    end
  private
  def show_spinner(msg_start, msg_end= "Concluido")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
