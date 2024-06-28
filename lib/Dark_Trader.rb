require 'nokogiri'
require 'open-uri'

# Fonction pour récupérer les prix des cryptomonnaies
def get_crypto_prices
  url = 'https://coinmarketcap.com/all/views/all/'
  page = Nokogiri::HTML(URI.open(url)) # Utilisation de URI.open pour ouvrir l'URL

  crypto_data = [] # Tableau pour stocker les données des cryptomonnaies
  crypto_rows = page.css('.sc-16r8icm-0.kXPxjK') # Sélecteur pour les noms des cryptomonnaies
  crypto_prices = page.css('.priceValue___11gHJ') # Sélecteur pour les prix en euros

  # Parcours des noms et des prix, puis ajout dans le tableau crypto_data
  crypto_rows.zip(crypto_prices).each do |row, price|
    name = row.text
    price_eur = price.text.gsub(' €', '').to_f
    crypto_data << { name => price_eur }
  end

  crypto_data # Renvoie le tableau complet
end

# Exécution de la fonction si le fichier est exécuté directement
if __FILE__ == $PROGRAM_NAME
  crypto_prices = get_crypto_prices
  puts crypto_prices
end
