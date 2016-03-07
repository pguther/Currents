from currentsArticleParser import CurrentsArticleParser
import requests
parser = CurrentsArticleParser()

# parser.scrape_url('http://currents.ucsc.edu/06-07/03-19/faults.asp')

article_url_list = []

try:
    fi = open('filenames.txt', "r")
    for article_url in fi:
        article_url = article_url.rstrip()
        article_url_list.append(article_url)
    fi.close()
except IOError:
    print "Error: File does not appear to exist."


# article_url_list = ['http://www1.ucsc.edu/currents/03-04/12-08/CURRENTS ONLINE/03-04/11-10/firefighters.html',]

parser.run_parser(article_url_list)
# parser.temp_driver('http://www1.ucsc.edu/currents/00-01/01-01/coastal.html')
# parser.temp_driver('http://www1.ucsc.edu/currents/03-04/12-08/CURRENTS%20ONLINE/03-04/11-17/activism.html')
