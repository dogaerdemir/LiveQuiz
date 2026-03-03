//
//  QuestionBank.swift
//  flashquiz
//

import Foundation

enum QuestionBank {
    static let defaultRoundQuestionCount: Int = 10

    private static let historyBaseQuestions: [QuizQuestion] = [
        QuizQuestion(
            text: "Türkiye'nin başkenti neresidir?",
            options: ["İstanbul", "Ankara", "İzmir", "Bursa"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "Türkiye Cumhuriyeti hangi yılda ilan edilmiştir?",
            options: ["1919", "1920", "1923", "1925"],
            correctOptionIndex: 2,
            category: .history
        ),
        QuizQuestion(
            text: "Mustafa Kemal Atatürk'ün doğduğu şehir hangisidir?",
            options: ["Selanik", "İstanbul", "Ankara", "Samsun"],
            correctOptionIndex: 0,
            category: .history
        ),
        QuizQuestion(
            text: "İstanbul'un fethi hangi yılda gerçekleşmiştir?",
            options: ["1071", "1453", "1517", "1923"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "TBMM hangi yılda açılmıştır?",
            options: ["1920", "1921", "1922", "1923"],
            correctOptionIndex: 0,
            category: .history
        ),
        QuizQuestion(
            text: "İstiklal Marşı'nın yazarı kimdir?",
            options: ["Namık Kemal", "Yahya Kemal", "Mehmet Akif Ersoy", "Tevfik Fikret"],
            correctOptionIndex: 2,
            category: .history
        ),
        QuizQuestion(
            text: "Lozan Barış Antlaşması hangi yılda imzalanmıştır?",
            options: ["1918", "1920", "1921", "1923"],
            correctOptionIndex: 3,
            category: .history
        ),
        QuizQuestion(
            text: "Nutuk adlı eserin yazarı kimdir?",
            options: ["Namık Kemal", "Ziya Gökalp", "Halide Edip Adıvar", "Mustafa Kemal Atatürk"],
            correctOptionIndex: 3,
            category: .history
        ),
        QuizQuestion(
            text: "Malazgirt Meydan Muharebesi hangi yılda yapılmıştır?",
            options: ["1299", "1071", "1453", "1517"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "Çanakkale Savaşı hangi yıl başlamıştır?",
            options: ["1914", "1916", "1915", "1918"],
            correctOptionIndex: 2,
            category: .history
        ),
        QuizQuestion(
            text: "Fransız İhtilali hangi yılda başlamıştır?",
            options: ["1789", "1815", "1776", "1848"],
            correctOptionIndex: 0,
            category: .history
        ),
        QuizQuestion(
            text: "ABD Bağımsızlık Bildirgesi hangi yılda ilan edilmiştir?",
            options: ["1492", "1776", "1917", "1865"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "Berlin Duvarı hangi yıl yıkılmıştır?",
            options: ["1961", "1979", "1991", "1989"],
            correctOptionIndex: 3,
            category: .history
        ),
        QuizQuestion(
            text: "Rönesans ilk olarak hangi ülkede başlamıştır?",
            options: ["İtalya", "Fransa", "İngiltere", "İspanya"],
            correctOptionIndex: 0,
            category: .history
        ),
        QuizQuestion(
            text: "I. Dünya Savaşı hangi yılda başlamıştır?",
            options: ["1912", "1918", "1914", "1939"],
            correctOptionIndex: 2,
            category: .history
        ),
        QuizQuestion(
            text: "Osmanlı Devleti'nin kuruluş yılı hangisidir?",
            options: ["1071", "1299", "1453", "1514"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "Magna Carta hangi yılda imzalanmıştır?",
            options: ["1215", "1066", "1492", "1314"],
            correctOptionIndex: 0,
            category: .history
        ),
        QuizQuestion(
            text: "Ay'a ayak basan ilk insan kimdir?",
            options: ["Yuri Gagarin", "Buzz Aldrin", "Neil Armstrong", "John Glenn"],
            correctOptionIndex: 2,
            category: .history
        ),
        QuizQuestion(
            text: "Dünyanın ilk yapay uydusunun adı nedir?",
            options: ["Apollo 11", "Sputnik 1", "Voyager 1", "Hubble"],
            correctOptionIndex: 1,
            category: .history
        ),
        QuizQuestion(
            text: "DNA'nın çift sarmal yapısını açıklayan bilim insanları kimlerdir?",
            options: ["Einstein ve Bohr", "Darwin ve Wallace", "Pasteur ve Koch", "Watson ve Crick"],
            correctOptionIndex: 3,
            category: .history
        ),
    ]

    private static let biologyBaseQuestions: [QuizQuestion] = [
        QuizQuestion(
            text: "H2O kimyasal formülü neyi ifade eder?",
            options: ["Tuz", "Su", "Oksijen", "Karbondioksit"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "Fotosentezde görevli organel hangisidir?",
            options: ["Kloroplast", "Mitokondri", "Çekirdek", "Ribozom"],
            correctOptionIndex: 0,
            category: .biology
        ),
        QuizQuestion(
            text: "İnsan kalbi kaç odacıktan oluşur?",
            options: ["2", "3", "4", "5"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "ABO kan grubu sistemini keşfeden bilim insanı kimdir?",
            options: ["Louis Pasteur", "Karl Landsteiner", "Gregor Mendel", "Robert Koch"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "Sağlıklı bir insanda kromozom sayısı kaçtır?",
            options: ["44", "45", "48", "46"],
            correctOptionIndex: 3,
            category: .biology
        ),
        QuizQuestion(
            text: "Canlıların enerji üretiminde kullandığı temel gaz hangisidir?",
            options: ["Oksijen", "Azot", "Helyum", "Hidrojen"],
            correctOptionIndex: 0,
            category: .biology
        ),
        QuizQuestion(
            text: "Mitokondrinin temel görevi nedir?",
            options: ["Protein sentezi", "DNA depolama", "ATP üretimi", "Yağ depolama"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "Genetik biliminin babası olarak kabul edilen kişi kimdir?",
            options: ["Darwin", "Mendel", "Lamarck", "Faraday"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "Bitkilerde yapraklardan su kaybı olayına ne ad verilir?",
            options: ["Fermantasyon", "Solunum", "Difüzyon", "Transpirasyon"],
            correctOptionIndex: 3,
            category: .biology
        ),
        QuizQuestion(
            text: "İnsan vücudundaki en büyük organ hangisidir?",
            options: ["Deri", "Karaciğer", "Akciğer", "Kalp"],
            correctOptionIndex: 0,
            category: .biology
        ),
        QuizQuestion(
            text: "Beynin denge ve koordinasyondan sorumlu bölümü hangisidir?",
            options: ["Omurilik", "Hipotalamus", "Beyincik", "Amigdala"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "COVID-19 hastalığına yol açan virüsün adı nedir?",
            options: ["H1N1", "SARS-CoV-2", "MERS-CoV", "Ebola"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "Antibiyotikler temel olarak hangi canlılara karşı etkilidir?",
            options: ["Virüsler", "Mantarlar", "Bakteriler", "Parazitler"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "Osmoz nedir?",
            options: ["Suyun yarı geçirgen zardan geçişi", "Işığın kırılması", "DNA'nın eşlenmesi", "Protein yıkımı"],
            correctOptionIndex: 0,
            category: .biology
        ),
        QuizQuestion(
            text: "Hücrenin yönetim merkezi hangi organeldir?",
            options: ["Golgi", "Çekirdek", "Lizozom", "Sentrozom"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "CPU kısaltmasının açılımı nedir?",
            options: ["Central Processing Unit", "Computer Power Utility", "Control Program Unit", "Central Program Utility"],
            correctOptionIndex: 0,
            category: .biology
        ),
        QuizQuestion(
            text: "RAM belleğin temel özelliği aşağıdakilerden hangisidir?",
            options: ["Kalıcı depolama sağlar", "Sadece okunabilir", "Uçucu (geçici) bellektir", "Sadece grafik verisi tutar"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "JSON kısaltmasının açılımı nedir?",
            options: ["Java Source Object Notation", "JavaScript Object Notation", "Joined Standard Object Name", "Java Serialized Object Network"],
            correctOptionIndex: 1,
            category: .biology
        ),
        QuizQuestion(
            text: "HTTPS kısaltmasındaki S harfi neyi ifade eder?",
            options: ["Simple", "Server", "Secure", "Source"],
            correctOptionIndex: 2,
            category: .biology
        ),
        QuizQuestion(
            text: "Uzak depodaki değişiklikleri çekip birleştirmek için hangi Git komutu kullanılır?",
            options: ["git push", "git clone", "git pull", "git commit"],
            correctOptionIndex: 2,
            category: .biology
        ),
    ]

    private static let technologyBaseQuestions: [QuizQuestion] = [
        QuizQuestion(
            text: "İkili (binary) sayı sistemi kaç tabanlıdır?",
            options: ["2", "8", "10", "16"],
            correctOptionIndex: 0,
            category: .technology
        ),
        QuizQuestion(
            text: "URL kısaltmasının açılımı nedir?",
            options: ["Unified Resource Layer", "Uniform Resource Locator", "Universal Routing Link", "Uniform Readable Location"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "API kısaltmasının açılımı nedir?",
            options: ["Applied Program Internet", "Application Programming Interface", "Application Process Integration", "Advanced Program Interaction"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "HTTP 404 durum kodu neyi ifade eder?",
            options: ["Başarılı", "Sunucu hatası", "Bulunamadı", "Yetkisiz"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "Unicode ne için kullanılır?",
            options: ["Karakter kodlama standardı", "Veri sıkıştırma", "Ağ güvenliği", "Resim işleme"],
            correctOptionIndex: 0,
            category: .technology
        ),
        QuizQuestion(
            text: "NFC teknolojisinin açılımı nedir?",
            options: ["New Frequency Code", "Near Field Communication", "Network File Control", "Next Form Connection"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "Bluetooth teknolojisi en çok ne için kullanılır?",
            options: ["Uydu iletişimi", "Web hosting", "Kısa mesafe kablosuz bağlantı", "Uzun menzil radar"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "Linux çekirdeğinin geliştiricisi kimdir?",
            options: ["Linus Torvalds", "Bill Gates", "Steve Jobs", "Dennis Ritchie"],
            correctOptionIndex: 0,
            category: .technology
        ),
        QuizQuestion(
            text: "iPhone ilk kez hangi yılda tanıtıldı?",
            options: ["2005", "2006", "2007", "2008"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "World Wide Web'in mucidi kimdir?",
            options: ["Alan Turing", "Tim Berners-Lee", "Steve Wozniak", "Elon Musk"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "GPU'nun temel kullanım amacı nedir?",
            options: ["Ses kaydı", "Metin düzenleme", "Grafik ve paralel işlem", "Disk bölümlendirme"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "SwiftUI'da arayüzde tekrar eden veri listesi için kullanılan yapı hangisidir?",
            options: ["Stack", "Form", "Canvas", "List"],
            correctOptionIndex: 3,
            category: .technology
        ),
        QuizQuestion(
            text: "SwiftUI'da bir state değişkeni hangi property wrapper ile tanımlanır?",
            options: ["@State", "@Binding", "@ObservedObject", "@Environment"],
            correctOptionIndex: 0,
            category: .technology
        ),
        QuizQuestion(
            text: "2022 FIFA Dünya Kupası'nı hangi ülke kazandı?",
            options: ["Fransa", "Arjantin", "Brezilya", "Hırvatistan"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "Basketbolda bir takım sahada kaç oyuncuyla oynar?",
            options: ["5", "6", "7", "11"],
            correctOptionIndex: 0,
            category: .technology
        ),
        QuizQuestion(
            text: "Voleybolda bir takım sahada kaç oyuncu bulunur?",
            options: ["4", "5", "6", "7"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "Olimpiyat halkalarının sayısı kaçtır?",
            options: ["4", "5", "6", "7"],
            correctOptionIndex: 1,
            category: .technology
        ),
        QuizQuestion(
            text: "Maraton koşusunun resmi mesafesi kaç kilometredir?",
            options: ["40", "41", "42", "42.195"],
            correctOptionIndex: 3,
            category: .technology
        ),
        QuizQuestion(
            text: "100 metre dünya rekorunun sahibi kimdir?",
            options: ["Tyson Gay", "Yohan Blake", "Usain Bolt", "Asafa Powell"],
            correctOptionIndex: 2,
            category: .technology
        ),
        QuizQuestion(
            text: "Toprak kortta oynanan Grand Slam turnuvası hangisidir?",
            options: ["Wimbledon", "Roland Garros", "US Open", "Australian Open"],
            correctOptionIndex: 1,
            category: .technology
        ),
    ]

    private static let sportsBaseQuestions: [QuizQuestion] = [
        QuizQuestion(
            text: "Futbolda hat-trick ne anlama gelir?",
            options: ["Bir oyuncunun 3 gol atması", "Maçın uzatmaya gitmesi", "Kalecinin penaltı kurtarması", "Kırmızı kart görmek"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "NBA kısaltmasının açılımı nedir?",
            options: ["National Basketball Association", "National Baseball Arena", "New Basket Alliance", "North Basket Association"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Super Bowl hangi spor dalının final karşılaşmasıdır?",
            options: ["Basketbol", "Beyzbol", "Amerikan futbolu", "Buz hokeyi"],
            correctOptionIndex: 2,
            category: .sports
        ),
        QuizQuestion(
            text: "Wimbledon turnuvası hangi spor dalına aittir?",
            options: ["Golf", "Tenis", "Atletizm", "Yüzme"],
            correctOptionIndex: 1,
            category: .sports
        ),
        QuizQuestion(
            text: "Türkiye'nin en üst seviye futbol ligi hangisidir?",
            options: ["1. Lig", "Bölgesel Amatör Lig", "Türkiye Kupası", "Süper Lig"],
            correctOptionIndex: 3,
            category: .sports
        ),
        QuizQuestion(
            text: "Bir futbol maçının normal süresi kaç dakikadır?",
            options: ["80", "90", "100", "120"],
            correctOptionIndex: 1,
            category: .sports
        ),
        QuizQuestion(
            text: "Satrançta oyun başında her oyuncunun kaç taşı vardır?",
            options: ["12", "14", "16", "18"],
            correctOptionIndex: 2,
            category: .sports
        ),
        QuizQuestion(
            text: "Yaz Olimpiyat Oyunları kaç yılda bir düzenlenir?",
            options: ["4", "2", "3", "5"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Futbolda penaltı noktası kaleye kaç metre uzaklıktadır?",
            options: ["9", "10", "12", "11"],
            correctOptionIndex: 3,
            category: .sports
        ),
        QuizQuestion(
            text: "Basketbolda üç sayı çizgisinin gerisinden atılan şut kaç puandır?",
            options: ["3", "2", "1", "4"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Teniste deuce durumu neyi ifade eder?",
            options: ["Setin bitmesini", "40-40 eşitliği", "Tie-break", "Maç puanı"],
            correctOptionIndex: 1,
            category: .sports
        ),
        QuizQuestion(
            text: "Voleybolda bir set genellikle kaç sayıda biter?",
            options: ["21", "15", "25", "30"],
            correctOptionIndex: 2,
            category: .sports
        ),
        QuizQuestion(
            text: "FIFA'nın merkezi hangi şehirdedir?",
            options: ["Zürih", "Londra", "Paris", "Madrid"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Fransa'nın başkenti neresidir?",
            options: ["Paris", "Lyon", "Marsilya", "Nice"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Londra'dan geçen nehrin adı nedir?",
            options: ["Seine", "Tuna", "Nil", "Thames"],
            correctOptionIndex: 3,
            category: .sports
        ),
        QuizQuestion(
            text: "Dünyanın en büyük okyanusu hangisidir?",
            options: ["Pasifik", "Atlas", "Hint", "Arktik"],
            correctOptionIndex: 0,
            category: .sports
        ),
        QuizQuestion(
            text: "Sahra Çölü hangi kıtadadır?",
            options: ["Asya", "Avrupa", "Afrika", "Güney Amerika"],
            correctOptionIndex: 2,
            category: .sports
        ),
        QuizQuestion(
            text: "Dünyanın en yüksek dağı hangisidir?",
            options: ["K2", "Everest", "Ağrı", "Elbruz"],
            correctOptionIndex: 1,
            category: .sports
        ),
        QuizQuestion(
            text: "Türkiye'nin kuzeyinde bulunan deniz hangisidir?",
            options: ["Ege Denizi", "Karadeniz", "Akdeniz", "Marmara Denizi"],
            correctOptionIndex: 1,
            category: .sports
        ),
        QuizQuestion(
            text: "Yüz ölçümü en büyük kıta hangisidir?",
            options: ["Asya", "Afrika", "Avrupa", "Antarktika"],
            correctOptionIndex: 0,
            category: .sports
        ),
    ]

    private static let generalKnowledgeBaseQuestions: [QuizQuestion] = [
        QuizQuestion(
            text: "Piramitleri ile ünlü ülke hangisidir?",
            options: ["Meksika", "Peru", "Mısır", "İtalya"],
            correctOptionIndex: 2,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Ekvator çizgisi Dünya'yı nasıl böler?",
            options: ["Doğu-Batı", "Karalar-Denizler", "Kuzey-Güney", "Sıcak-Soğuk"],
            correctOptionIndex: 2,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Avustralya'nın başkenti neresidir?",
            options: ["Sidney", "Melbourne", "Perth", "Canberra"],
            correctOptionIndex: 3,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Japonya'nın başkenti neresidir?",
            options: ["Osaka", "Tokyo", "Kyoto", "Nagoya"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Kanada'nın başkenti neresidir?",
            options: ["Toronto", "Vancouver", "Ottawa", "Montreal"],
            correctOptionIndex: 2,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Dünya'nın doğal uydusu hangisidir?",
            options: ["Mars", "Ay", "Venüs", "Jüpiter"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Deniz seviyesinde su kaç derecede kaynar?",
            options: ["90°C", "100°C", "110°C", "120°C"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Altının kimyasal sembolü nedir?",
            options: ["Ag", "Au", "Fe", "Pb"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Işığın boşluktaki hızı yaklaşık kaç km/s'dir?",
            options: ["30.000", "150.000", "300.000", "1.000.000"],
            correctOptionIndex: 2,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Kuvvetin SI birimi hangisidir?",
            options: ["Newton", "Pascal", "Joule", "Watt"],
            correctOptionIndex: 0,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Demirin kimyasal sembolü hangisidir?",
            options: ["Ir", "In", "Dm", "Fe"],
            correctOptionIndex: 3,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Pi sayısının yaklaşık değeri hangisidir?",
            options: ["3.14", "2.71", "1.61", "1.41"],
            correctOptionIndex: 0,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Güneş Sistemi'nin en büyük gezegeni hangisidir?",
            options: ["Dünya", "Satürn", "Neptün", "Jüpiter"],
            correctOptionIndex: 3,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Aşağıdakilerden hangisi asal sayıdır?",
            options: ["21", "29", "35", "39"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Kızıl Gezegen olarak bilinen gezegen hangisidir?",
            options: ["Venüs", "Merkür", "Mars", "Satürn"],
            correctOptionIndex: 2,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Eriyen buz hangi sıcaklıkta suya dönüşür? (deniz seviyesi)",
            options: ["-10°C", "0°C", "10°C", "32°C"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Aşağıdakilerden hangisi bir programlama dilidir?",
            options: ["Swift", "HTML", "Photoshop", "MySQL Server"],
            correctOptionIndex: 0,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "SQL en temelde ne için kullanılır?",
            options: ["Resim düzenleme", "Veritabanı sorgulama", "Video işleme", "İşletim sistemi kurma"],
            correctOptionIndex: 1,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Yapay zekanın İngilizce kısaltması hangisidir?",
            options: ["VR", "AR", "ML", "AI"],
            correctOptionIndex: 3,
            category: .generalKnowledge
        ),
        QuizQuestion(
            text: "Bulut bilişim (cloud computing) neyi ifade eder?",
            options: ["İnternet üzerinden kaynak ve servis sunumu", "Sadece hava durumu analizi", "Bilgisayar kasası soğutması", "Yalnızca yerel ağ depolaması"],
            correctOptionIndex: 0,
            category: .generalKnowledge
        )
    ]

    private static let historyExtraQuestions: [QuizQuestion] = [
        QuizQuestion(text: "Roma İmparatorluğu resmi olarak ikiye kaç yılında ayrıldı?", options: ["330", "395", "476", "565"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Bizans İmparatorluğu'nun başkenti neresiydi?", options: ["Atina", "Roma", "Konstantinopolis", "İskenderiye"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Anadolu Selçuklu Devleti'nin kurucusu kimdir?", options: ["Alparslan", "Kutalmışoğlu Süleyman Şah", "I. Kılıçarslan", "II. Kılıçarslan"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Fatih Sultan Mehmet kaçıncı Osmanlı padişahıdır?", options: ["5", "6", "7", "8"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Kanuni Sultan Süleyman hangi yüzyılda hüküm sürmüştür?", options: ["14. yüzyıl", "15. yüzyıl", "16. yüzyıl", "17. yüzyıl"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Bastille Hapishanesi baskını hangi tarihte gerçekleşti?", options: ["14 Temmuz 1789", "1 Mayıs 1789", "4 Temmuz 1776", "29 Ekim 1789"], correctOptionIndex: 0, category: .history),
        QuizQuestion(text: "Sanayi Devrimi ilk olarak hangi ülkede başladı?", options: ["Fransa", "İngiltere", "Almanya", "ABD"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Amerikan İç Savaşı hangi yıllar arasında gerçekleşti?", options: ["1850-1854", "1861-1865", "1871-1875", "1914-1918"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "II. Dünya Savaşı Avrupa'da hangi yılda sona erdi?", options: ["1943", "1944", "1945", "1946"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "NATO hangi yılda kuruldu?", options: ["1945", "1949", "1952", "1955"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Birleşmiş Milletler hangi yılda kuruldu?", options: ["1945", "1948", "1950", "1952"], correctOptionIndex: 0, category: .history),
        QuizQuestion(text: "Tanzimat Fermanı hangi yıl ilan edilmiştir?", options: ["1839", "1856", "1876", "1908"], correctOptionIndex: 0, category: .history),
        QuizQuestion(text: "Islahat Fermanı hangi yılda ilan edilmiştir?", options: ["1839", "1856", "1876", "1913"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Başkomutanlık Meydan Muharebesi hangi yılda yapılmıştır?", options: ["1920", "1921", "1922", "1923"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Sakarya Meydan Muharebesi hangi yılda yapılmıştır?", options: ["1919", "1920", "1921", "1922"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Cumhuriyet'in ilk başbakanı kimdir?", options: ["Fevzi Çakmak", "İsmet İnönü", "Celal Bayar", "Kazım Karabekir"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Mısır piramitlerinin en büyüğü hangisidir?", options: ["Mikerinos", "Kefren", "Keops", "Sakkara"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Jül Sezar hangi uygarlığın lideridir?", options: ["Yunan", "Pers", "Roma", "Mısır"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Orta Çağ'ın sonunu simgeleyen olay hangisidir?", options: ["Fransız İhtilali", "İstanbul'un Fethi", "Sanayi Devrimi", "Berlin Duvarı'nın yıkılması"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Feodalite en yaygın olarak hangi kıtada görülmüştür?", options: ["Asya", "Afrika", "Avrupa", "Amerika"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Haçlı Seferleri'nin temel hedefi hangi şehirdi?", options: ["Roma", "Kudüs", "Paris", "Viyana"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Reform hareketini başlatan kişi kimdir?", options: ["Martin Luther", "Calvin", "Erasmus", "Galileo"], correctOptionIndex: 0, category: .history),
        QuizQuestion(text: "Ümit Burnu'nu geçen ilk Avrupalı denizci kimdir?", options: ["Vasco da Gama", "Bartolomeu Dias", "Magellan", "Kolomb"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Amerika kıtasına ulaşan denizci kimdir?", options: ["Macellan", "Cabot", "Kolomb", "Cook"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Kanun-i Esasi hangi yılda ilan edilmiştir?", options: ["1839", "1856", "1876", "1908"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "I. Meşrutiyet hangi padişah döneminde ilan edilmiştir?", options: ["Abdülaziz", "II. Abdülhamid", "V. Mehmet", "II. Mahmud"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "II. Meşrutiyet hangi yılda ilan edilmiştir?", options: ["1876", "1908", "1919", "1923"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Trablusgarp Savaşı hangi devletle yapılmıştır?", options: ["Yunanistan", "İtalya", "Rusya", "İngiltere"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Mondros Ateşkes Antlaşması hangi yıl imzalanmıştır?", options: ["1916", "1917", "1918", "1919"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Sevr Antlaşması hangi yıl imzalanmıştır?", options: ["1918", "1919", "1920", "1921"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Saltanat hangi yıl kaldırılmıştır?", options: ["1920", "1921", "1922", "1924"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Halifelik hangi yıl kaldırılmıştır?", options: ["1922", "1923", "1924", "1928"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Türkiye'de Latin alfabesine geçiş hangi yılda olmuştur?", options: ["1924", "1926", "1928", "1930"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Kadınlara milletvekili seçme ve seçilme hakkı hangi yılda verildi?", options: ["1930", "1932", "1934", "1938"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "Berlin Kongresi hangi yılda toplanmıştır?", options: ["1871", "1878", "1881", "1893"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Viyana Kongresi hangi yılda toplanmıştır?", options: ["1789", "1815", "1848", "1870"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Sovyetler Birliği hangi yılda dağılmıştır?", options: ["1989", "1991", "1993", "1995"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Kadeş Antlaşması'nın taraflarından biri aşağıdakilerden hangisidir?", options: ["Asurlar", "Hititler", "Urartular", "Frigler"], correctOptionIndex: 1, category: .history),
        QuizQuestion(text: "Tarihte bilinen ilk yazılı antlaşma hangisidir?", options: ["Westphalia", "Versailles", "Kadeş", "Berlin"], correctOptionIndex: 2, category: .history),
        QuizQuestion(text: "1453'te fethedilen şehir hangisidir?", options: ["Roma", "Konstantinopolis", "Kudüs", "Şam"], correctOptionIndex: 1, category: .history)
    ]

    private static let biologyExtraQuestions: [QuizQuestion] = [
        QuizQuestion(text: "Protein sentezinde doğrudan görev alan organel hangisidir?", options: ["Lizozom", "Ribozom", "Kloroplast", "Sentrozom"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "DNA'daki şeker molekülü hangisidir?", options: ["Riboz", "Deoksiriboz", "Fruktoz", "Sükroz"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "RNA'da timin yerine hangi baz bulunur?", options: ["Adenin", "Sitozin", "Urasil", "Guanin"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "İnsanlarda solunum sisteminin ana organı hangisidir?", options: ["Kalp", "Böbrek", "Akciğer", "Karaciğer"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Sindirim en yoğun hangi organda gerçekleşir?", options: ["Mide", "İnce bağırsak", "Kalın bağırsak", "Yemek borusu"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Kanı süzen organ hangisidir?", options: ["Karaciğer", "Mide", "Böbrek", "Pankreas"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "İnsülin hormonu hangi organdan salgılanır?", options: ["Tiroid", "Pankreas", "Hipofiz", "Dalak"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Bitkilerde köklerin temel görevi nedir?", options: ["Fotosentez", "Su ve mineral alma", "Tohum üretme", "Polen taşıma"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Ekosistemde üretici canlılara örnek hangisidir?", options: ["Mantar", "İnsan", "Yeşil bitki", "Bakteri"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Canlıların kalıtsal bilgisini taşıyan birim nedir?", options: ["Enzim", "Gen", "Hormon", "Lipit"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Mitoz bölünme sonucu kaç hücre oluşur?", options: ["1", "2", "3", "4"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Mayoz bölünme sonucu kaç hücre oluşur?", options: ["2", "3", "4", "8"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Vücudumuzda oksijeni taşıyan protein hangisidir?", options: ["Keratin", "Hemoglobin", "İnsülin", "Kollajen"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Bağışıklık sisteminin temel hücrelerinden biri hangisidir?", options: ["Alyuvar", "Lökosit", "Trombosit", "Nöron"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Sinir hücresine ne ad verilir?", options: ["Nefron", "Nöron", "Akson", "Miyelin"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Gözün ışığı algılayan tabakası hangisidir?", options: ["Kornea", "Retina", "Sklera", "İris"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Kalpte kanın tek yönlü akışını sağlayan yapı hangisidir?", options: ["Kapakçık", "Atardamar", "Toplardamar", "Kılcal damar"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Aşağıdakilerden hangisi omurgalı bir canlıdır?", options: ["Sünger", "Denizanası", "Kurbağa", "Toprak solucanı"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Canlıların sınıflandırılmasında en geniş birim hangisidir?", options: ["Tür", "Cins", "Alem", "Familya"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Mantarlar besinlerini nasıl alır?", options: ["Fotosentezle", "Dışarıdan emilimle", "Kemirerek", "Ağızla çiğneyerek"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Virüsler için hangisi doğrudur?", options: ["Hücresel yapıları tamdır", "Kendi başına çoğalabilir", "Zorunlu parazittir", "Her zaman faydalıdır"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Bitki hücresinde hayvan hücresinden farklı olarak hangisi bulunur?", options: ["Mitokondri", "Golgi", "Hücre duvarı", "Ribozom"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Solunumda ATP üretiminin büyük kısmı hangi organelde olur?", options: ["Çekirdek", "Mitokondri", "Ribozom", "Koful"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Canlılarda büyüme ve gelişmeyi sağlayan temel olay hangisidir?", options: ["Bölünme", "Sindirim", "Boşaltım", "Dolaşım"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Kanın pıhtılaşmasında görevli hücre parçacığı hangisidir?", options: ["Alyuvar", "Akyuvar", "Trombosit", "Plazma"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "İskelet kasları istemli midir?", options: ["Evet", "Hayır", "Yalnızca çocuklarda", "Yalnızca sporcularda"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Nefron hangi organda bulunur?", options: ["Karaciğer", "Kalp", "Böbrek", "Akciğer"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Bitkilerde gaz alışverişini sağlayan yapı hangisidir?", options: ["Stoma", "Kök tüyü", "Tohum", "Çenek"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Evrim teorisiyle özdeşleşen bilim insanı kimdir?", options: ["Darwin", "Newton", "Faraday", "Pasteur"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Mendel çalışmalarını hangi canlı üzerinde yapmıştır?", options: ["Mısır", "Bezelye", "Buğday", "Fasulye"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Dolaşım sistemi hangi iki ana damar tipinden oluşur?", options: ["Kılcal ve sinir", "Atardamar ve toplardamar", "Lenf ve kıkırdak", "Kemik ve kas"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Endokrin bezler salgılarını nereye verir?", options: ["Kanal içine", "Kana", "Mideye", "Deriye"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Aşağıdakilerden hangisi bir doku türüdür?", options: ["Sinir doku", "DNA doku", "Protein doku", "Hormon doku"], correctOptionIndex: 0, category: .biology),
        QuizQuestion(text: "Omurgalılarda merkezi sinir sistemi hangi yapılardan oluşur?", options: ["Kalp ve damar", "Beyin ve omurilik", "Mide ve bağırsak", "Böbrek ve mesane"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Klorofilin temel görevi nedir?", options: ["Protein üretimi", "Işık enerjisini tutmak", "Su depolamak", "Mineral taşımak"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "İnsanlarda en büyük iç organ hangisidir?", options: ["Kalp", "Akciğer", "Karaciğer", "Mide"], correctOptionIndex: 2, category: .biology),
        QuizQuestion(text: "Vücut sıcaklığını düzenleyen beyin bölgesi hangisidir?", options: ["Beyincik", "Hipotalamus", "Omurilik soğanı", "Korteks"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Aşıların temel amacı nedir?", options: ["Kas gücünü artırmak", "Bağışıklık hafızası oluşturmak", "Büyümeyi hızlandırmak", "Sindirim kolaylaştırmak"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Hücresel solunumun hammaddelerinden biri hangisidir?", options: ["Klorofil", "Glikoz", "Aminoasit", "DNA"], correctOptionIndex: 1, category: .biology),
        QuizQuestion(text: "Aşağıdakilerden hangisi bir enzim özelliğidir?", options: ["Tepkimede harcanmak", "Reaksiyonu yavaşlatmak", "Canlılarda katalizör olmak", "Sadece bitkilerde bulunmak"], correctOptionIndex: 2, category: .biology)
    ]

    private static let technologyExtraQuestions: [QuizQuestion] = [
        QuizQuestion(text: "Bilgisayarda işlem sırasını belirleyen temel yapı hangisidir?", options: ["Algoritma", "Klavye", "Monitör", "Tarayıcı"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "SSD ile HDD arasındaki temel fark nedir?", options: ["SSD mekaniktir", "HDD daha sessizdir", "SSD daha hızlıdır", "HDD elektriksiz çalışır"], correctOptionIndex: 2, category: .technology),
        QuizQuestion(text: "IP adresinin görevi nedir?", options: ["Ekran parlaklığı ayarı", "Ağdaki cihazı tanımlama", "Dosya sıkıştırma", "Klavye düzeni"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "LAN kısaltmasının açılımı nedir?", options: ["Large Area Network", "Local Area Network", "Linked Access Node", "Long Access Network"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Wi-Fi temel olarak hangi iletişim türüdür?", options: ["Kablolu ağ", "Kablosuz yerel ağ", "Uydu yayını", "Bluetooth eşleme"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Firewall ne için kullanılır?", options: ["Ekran koruyucu", "Ağ güvenliği", "Pil tasarrufu", "Yazıcı kurulumu"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "2FA (iki faktörlü kimlik doğrulama) ne sağlar?", options: ["Daha küçük dosya boyutu", "Ek güvenlik katmanı", "Daha hızlı internet", "Daha güçlü işlemci"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Aşağıdakilerden hangisi bir işletim sistemidir?", options: ["Swift", "Linux", "HTTP", "JSON"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Veritabanında birincil anahtar (primary key) ne işe yarar?", options: ["Renk ayarlamak", "Kayıtları benzersiz tanımlamak", "Dosya sıkıştırmak", "Metin biçimlendirmek"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "SQL'de veri silmek için hangi komut kullanılır?", options: ["DROP", "DELETE", "REMOVE", "ERASE"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Git'te yeni bir dal oluşturma komutu hangisidir?", options: ["git create", "git branch", "git fork", "git split"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "API endpoint'i nedir?", options: ["Sunucuya erişim noktası", "Monitör çözünürlüğü", "Klavye düzeni", "Dosya uzantısı"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "JSON verisi hangi yapıda tutulur?", options: ["Anahtar-değer", "Sadece sayı", "Sadece tablo", "Sadece resim"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "NoSQL veritabanları genelde ne için tercih edilir?", options: ["Sabit şemalı küçük tablolar", "Esnek şema ve yatay ölçekleme", "Yalnızca matematik işlemleri", "Yalnızca masaüstü uygulamalar"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Bulut depolama servisine örnek hangisidir?", options: ["Google Drive", "VLC", "Photoshop", "Xcode"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "Siber güvenlikte phishing nedir?", options: ["Donanım arızası", "Sahte mesajla bilgi çalma", "Disk birleştirme", "Veri sıkıştırma"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "VPN ne sağlar?", options: ["Yazıcı hızlandırma", "Şifreli ağ tüneli", "Ekran kaydı", "Klavye ışığı"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "HTML ne için kullanılır?", options: ["Sunucu yönetimi", "Web sayfası yapısı oluşturma", "Veritabanı indeksleme", "Resim sıkıştırma"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "CSS ne için kullanılır?", options: ["Stil ve görünüm", "Veritabanı sorgu", "İşletim sistemi kurulumu", "Ağ yönlendirme"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "JavaScript en yaygın olarak nerede kullanılır?", options: ["Web etkileşimi", "Sadece hesap makinesi", "Sadece oyun konsolu", "Sadece BIOS"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "HTTP hangi katmanda çalışır?", options: ["Uygulama katmanı", "Fiziksel katman", "Veri bağlantı", "Ağ arabirimi"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "HTTPS ile HTTP arasındaki ana fark nedir?", options: ["HTTPS şifreleme kullanır", "HTTP daha güvenlidir", "HTTPS internet gerektirmez", "HTTP yalnızca mobilde çalışır"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "DNS'in görevi nedir?", options: ["Dosya şifreleme", "Alan adını IP'ye çevirmek", "Ekran çözünürlüğü ayarlamak", "RAM temizlemek"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "MAC adresi neyi ifade eder?", options: ["Ağ kartının benzersiz adresi", "İşlemci tipi", "Monitör kodu", "Yazılım lisansı"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "RAM'in dolması en çok neyi etkiler?", options: ["Pil ömrü", "Anlık performans", "Kasa rengi", "Ekran boyutu"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Compiler'ın görevi nedir?", options: ["Kodu makine diline çevirmek", "Ekran görüntüsü almak", "Disk biçimlendirmek", "Ağ şifresi üretmek"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "Debugging ne anlama gelir?", options: ["Hata ayıklama", "Veri yedekleme", "Şifreleme", "Donanım temizliği"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "Cache bellek ne işe yarar?", options: ["Veriyi kalıcı saklamak", "Sık kullanılan veriye hızlı erişim", "Kablo bağlantısı kurmak", "Ses kartını yönetmek"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "64-bit mimarinin avantajlarından biri nedir?", options: ["Daha az RAM kullanması", "Daha geniş bellek adresleme", "İnterneti hızlandırması", "Ekran çözünürlüğünü artırması"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Docker ne için kullanılır?", options: ["Konteyner tabanlı uygulama çalıştırma", "Fotoğraf düzenleme", "Ses kaydı", "E-posta gönderme"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "CI/CD süreçleri neyi hedefler?", options: ["Daha yavaş yayın", "Sürekli entegrasyon ve dağıtım", "Sadece manuel test", "Ağ kapatma"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Machine Learning hangi alanın alt dalıdır?", options: ["Biyoloji", "Yapay zeka", "Coğrafya", "Muhasebe"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Prompt engineering en çok hangi teknolojiyle ilişkilidir?", options: ["3D yazıcı", "Büyük dil modelleri", "Bluetooth", "GPU fanı"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "TCP protokolünün temel özelliği nedir?", options: ["Bağlantısız ve hızlı", "Bağlantı yönelimli ve güvenilir", "Şifresiz aktarım", "Sadece yerel ağ"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "UDP için hangisi doğrudur?", options: ["Her paketi garanti eder", "Bağlantı yönelimlidir", "Daha düşük gecikme sunar", "Yalnızca web sayfası taşır"], correctOptionIndex: 2, category: .technology),
        QuizQuestion(text: "REST API'de GET metodu ne için kullanılır?", options: ["Veri çekmek", "Veri silmek", "Veri güncellemek", "Sunucuyu kapatmak"], correctOptionIndex: 0, category: .technology),
        QuizQuestion(text: "POST metodu genellikle ne için kullanılır?", options: ["Veri okumak", "Yeni veri oluşturmak", "Sunucu saatini değiştirmek", "Dosya yeniden adlandırmak"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Mobil uygulamada crash report aracı olarak hangisi bilinir?", options: ["CoreData", "Crashlytics", "UIKit", "WebKit"], correctOptionIndex: 1, category: .technology),
        QuizQuestion(text: "Swift dilini geliştiren şirket hangisidir?", options: ["Google", "Microsoft", "Apple", "IBM"], correctOptionIndex: 2, category: .technology),
        QuizQuestion(text: "Xcode ne için kullanılır?", options: ["iOS/macOS geliştirme ortamı", "Yalnızca fotoğraf işleme", "Yalnızca müzik prodüksiyonu", "Sadece veritabanı sunucusu"], correctOptionIndex: 0, category: .technology)
    ]

    private static let sportsExtraQuestions: [QuizQuestion] = [
        QuizQuestion(text: "UEFA Şampiyonlar Ligi şampiyonuna verilen kupanın yaygın adı nedir?", options: ["Altın Top", "Kupa 1", "Kulaklı Kupa", "Şampiyon Kalkanı"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Futbolda bir takımın sahadaki kaleci dahil oyuncu sayısı kaçtır?", options: ["10", "11", "12", "9"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Sarı kart gören oyuncu ikinci sarı kartta ne olur?", options: ["Oyunda kalır", "Yedek kulübesine gider", "Kırmızı kartla oyun dışı kalır", "Penaltı kullanır"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Basketbolda serbest atış çizgisinden atılan bir sayı kaç puandır?", options: ["1", "2", "3", "4"], correctOptionIndex: 0, category: .sports),
        QuizQuestion(text: "NBA'de normal sürede maç kaç periyottur?", options: ["2", "3", "4", "5"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Voleybolda takımın topa en fazla kaç kez vurma hakkı vardır?", options: ["2", "3", "4", "5"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Teniste bir sette tie-break genelde kaç sayıya oynanır?", options: ["5", "6", "7", "10"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "F1 yarışlarında pole pozisyonu ne demektir?", options: ["Son sıradan başlama", "En hızlı tur atma", "Yarışa ilk sıradan başlama", "Pit stop cezası"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Tour de France hangi spor dalıyla ilgilidir?", options: ["Yüzme", "Bisiklet", "Atletizm", "Motor sporları"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "UEFA EURO turnuvası kaç yılda bir düzenlenir?", options: ["2", "3", "4", "5"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "VAR sistemi en çok hangi sporda kullanılır?", options: ["Futbol", "Basketbol", "Tenis", "Hentbol"], correctOptionIndex: 0, category: .sports),
        QuizQuestion(text: "Hentbolda bir takım sahada kaç oyuncuyla oynar?", options: ["6", "7", "8", "9"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Beyzbolda bir inning kaç yarıdan oluşur?", options: ["1", "2", "3", "4"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Krikette sayı birimine ne ad verilir?", options: ["Goal", "Run", "Point", "Score"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Judo hangi ülke kökenlidir?", options: ["Çin", "Güney Kore", "Japonya", "Tayland"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Taekwondo hangi ülke kökenlidir?", options: ["Japonya", "Çin", "Güney Kore", "Vietnam"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Boks ringinde bir raund profesyonelde genelde kaç dakikadır?", options: ["2", "3", "4", "5"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Boksun efsane isimlerinden Muhammad Ali'nin eski adı nedir?", options: ["Cassius Clay", "Joe Frazier", "George Foreman", "Sonny Liston"], correctOptionIndex: 0, category: .sports),
        QuizQuestion(text: "Yüzmede serbest stilde en kısa olimpik mesafe nedir?", options: ["25 m", "50 m", "75 m", "100 m"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Atletizmde 110 metre engelli hangi kategoridedir?", options: ["Kadınlar", "Erkekler", "Karma", "Gençler"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Decathlon kaç branştan oluşur?", options: ["8", "9", "10", "12"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Triatlon hangi üç branşı içerir?", options: ["Koşu-Bisiklet-Yüzme", "Koşu-Halter-Yüzme", "Bisiklet-Judo-Koşu", "Yüzme-Kürek-Bisiklet"], correctOptionIndex: 0, category: .sports),
        QuizQuestion(text: "Futbolda ofsayt kuralı hangi unsurla ilgilidir?", options: ["Topa elle müdahale", "Oyuncunun konumu", "Korner kullanımı", "Taç atışı"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Penaltı atışı hangi noktadan kullanılır?", options: ["9 metre", "10 metre", "11 metre", "12 metre"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Basketbolda double-double neyi ifade eder?", options: ["İki oyuncunun sayı atması", "İki istatistikte çift hane", "İki uzatma oynanması", "İki teknik faul"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "EuroLeague hangi spor organizasyonudur?", options: ["Futbol", "Voleybol", "Basketbol", "Hentbol"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Teniste Grand Slam turnuvası sayısı kaçtır?", options: ["3", "4", "5", "6"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Grand Slam turnuvalarından hangisi çim kortta oynanır?", options: ["US Open", "Australian Open", "Wimbledon", "Roland Garros"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Roland Garros hangi şehirde düzenlenir?", options: ["Londra", "Paris", "Melbourne", "New York"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "US Open hangi ülkede düzenlenir?", options: ["İngiltere", "Fransa", "ABD", "Avustralya"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "FIFA Dünya Kupası kaç yılda bir yapılır?", options: ["2", "3", "4", "5"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Basketbolda bir takımın mola hakkı hangi organizasyona göre değişir?", options: ["Hakeme göre", "Lig kurallarına göre", "Seyirciye göre", "Kaptana göre"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Voleybolda libero oyuncusu hangi renkte forma giyer?", options: ["Her zaman siyah", "Takımla aynı", "Farklı renkte", "Sadece beyaz"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Satrançta şah mat ne anlama gelir?", options: ["Şahın tehdit edilmesi", "Beraberlik", "Oyunun bitmesi ve kazanma", "Piyon terfisi"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Curling hangi zeminde oynanır?", options: ["Çim", "Toprak", "Buz", "Ahşap"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Buz hokeyinde pak yerine kullanılan terim hangisidir?", options: ["Disk", "Top", "Puck", "Shot"], correctOptionIndex: 2, category: .sports),
        QuizQuestion(text: "Ragbi'de sayı getiren temel hareket hangisidir?", options: ["Try", "Serve", "Ace", "Smash"], correctOptionIndex: 0, category: .sports),
        QuizQuestion(text: "Formula 1'de DRS sistemi neyi kolaylaştırır?", options: ["Yakıt ikmali", "Geçiş yapmayı", "Lastik değişimi", "Motor soğutmayı"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "MotoGP hangi spor dalıdır?", options: ["Bisiklet", "Motosiklet yarışı", "Ralli", "Karting"], correctOptionIndex: 1, category: .sports),
        QuizQuestion(text: "Türkiye Basketbol Süper Ligi'nde maçlar kaç dakikadır (normal süre)?", options: ["32", "36", "40", "48"], correctOptionIndex: 2, category: .sports)
    ]

    private static let generalKnowledgeExtraQuestions: [QuizQuestion] = [
        QuizQuestion(text: "İspanya'nın başkenti neresidir?", options: ["Barselona", "Madrid", "Sevilla", "Valencia"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "İtalya'nın başkenti neresidir?", options: ["Milano", "Roma", "Napoli", "Torino"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Brezilya'nın başkenti neresidir?", options: ["Rio de Janeiro", "Sao Paulo", "Brasilia", "Salvador"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Arjantin'in başkenti hangisidir?", options: ["Lima", "Santiago", "Bogota", "Buenos Aires"], correctOptionIndex: 3, category: .generalKnowledge),
        QuizQuestion(text: "Mısır'ın başkenti neresidir?", options: ["Kahire", "İskenderiye", "Giza", "Luksor"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Hindistan'ın başkenti neresidir?", options: ["Mumbai", "Yeni Delhi", "Kalküta", "Bangalore"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Çin'in başkenti hangisidir?", options: ["Şanghay", "Pekin", "Guangzhou", "Shenzhen"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Rusya'nın başkenti neresidir?", options: ["St. Petersburg", "Moskova", "Kazan", "Soçi"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Almanya'nın başkenti neresidir?", options: ["Münih", "Hamburg", "Berlin", "Frankfurt"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Portekiz'in başkenti hangisidir?", options: ["Porto", "Lizbon", "Madrid", "Braga"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Nil Nehri hangi kıtadadır?", options: ["Asya", "Afrika", "Avrupa", "Güney Amerika"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Amazon Ormanları en çok hangi ülkede bulunur?", options: ["Peru", "Kolombiya", "Brezilya", "Bolivya"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Dünyanın en uzun nehri olarak genelde hangisi kabul edilir?", options: ["Amazon", "Nil", "Mississippi", "Yangtze"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Everest Dağı hangi dağ silsilesindedir?", options: ["Andlar", "Alpler", "Himalayalar", "Rocky"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Akdeniz hangi iki kıta arasında yer alır?", options: ["Avrupa-Afrika-Asya", "Asya-Avustralya", "Kuzey Amerika-Güney Amerika", "Avrupa-Antarktika"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Hangi ülke kangurularıyla ünlüdür?", options: ["Yeni Zelanda", "Avustralya", "Güney Afrika", "Kanada"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Dünyanın en soğuk kıtası hangisidir?", options: ["Avrupa", "Asya", "Kuzey Amerika", "Antarktika"], correctOptionIndex: 3, category: .generalKnowledge),
        QuizQuestion(text: "Mozart hangi alanda ünlüdür?", options: ["Ressamlık", "Müzik", "Heykel", "Mimarlık"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Mona Lisa tablosunun ressamı kimdir?", options: ["Van Gogh", "Picasso", "Leonardo da Vinci", "Michelangelo"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Romeo ve Juliet'i yazan kişi kimdir?", options: ["Shakespeare", "Dostoyevski", "Tolstoy", "Victor Hugo"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Nobel ödülleri hangi ülkede verilir?", options: ["Norveç ve İsveç", "Almanya ve Fransa", "ABD", "Japonya"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Oscar ödülleri hangi alan içindir?", options: ["Bilim", "Sinema", "Mimari", "Spor"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Güneşe en yakın gezegen hangisidir?", options: ["Venüs", "Merkür", "Dünya", "Mars"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Satürn'ün en bilinen özelliği nedir?", options: ["Mavi renkli olması", "Halkaları", "En sıcak gezegen olması", "Uydusuz olması"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Jüpiter hangi gezegen grubundadır?", options: ["Kayaç", "Cüce", "Gaz devi", "Buz cismi"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Ay tutulması sırasında Dünya hangi iki gök cismi arasına girer?", options: ["Güneş ve Mars", "Güneş ve Ay", "Ay ve Venüs", "Dünya ve Güneş"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Bir yıl kaç gündür? (artık yıl hariç)", options: ["364", "365", "366", "367"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Bir saatte kaç dakika vardır?", options: ["50", "60", "70", "100"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Türkiye'nin telefon ülke kodu kaçtır?", options: ["+90", "+44", "+1", "+49"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Avrupa Birliği bayrağında kaç yıldız bulunur?", options: ["10", "12", "15", "27"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "UNESCO'nun açılımı aşağıdakilerden hangisidir?", options: ["Eğitim, Bilim ve Kültür Örgütü", "Sağlık Örgütü", "Gıda Örgütü", "Göç Örgütü"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Dünyanın en kalabalık ülkesi güncel olarak hangisidir?", options: ["Hindistan", "Çin", "ABD", "Endonezya"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Kan grubu vericisi olarak 'evrensel verici' kabul edilen grup hangisidir?", options: ["A Rh+", "B Rh-", "AB Rh+", "0 Rh-"], correctOptionIndex: 3, category: .generalKnowledge),
        QuizQuestion(text: "Bir bilgisayarın beyni olarak da bilinen donanım hangisidir?", options: ["SSD", "RAM", "CPU", "GPU"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Ampulün icadıyla en çok ilişkilendirilen mucit kimdir?", options: ["Nikola Tesla", "Thomas Edison", "Alexander Graham Bell", "James Watt"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "Telefonu icat eden kişi olarak bilinen isim hangisidir?", options: ["Alexander Graham Bell", "Guglielmo Marconi", "Alan Turing", "Benjamin Franklin"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Para birimi Yen olan ülke hangisidir?", options: ["Çin", "Japonya", "Güney Kore", "Tayland"], correctOptionIndex: 1, category: .generalKnowledge),
        QuizQuestion(text: "İngiltere'nin para birimi nedir?", options: ["Euro", "Dolar", "Sterlin", "Frank"], correctOptionIndex: 2, category: .generalKnowledge),
        QuizQuestion(text: "Türkiye'nin en uzun nehri hangisidir?", options: ["Kızılırmak", "Fırat", "Sakarya", "Yeşilırmak"], correctOptionIndex: 0, category: .generalKnowledge),
        QuizQuestion(text: "Türkiye'nin yüzölçümü en büyük gölü hangisidir?", options: ["Beyşehir Gölü", "Van Gölü", "Tuz Gölü", "Eğirdir Gölü"], correctOptionIndex: 1, category: .generalKnowledge)
    ]

    private static let historyQuestions: [QuizQuestion] = historyBaseQuestions + historyExtraQuestions
    private static let biologyQuestions: [QuizQuestion] = biologyBaseQuestions + biologyExtraQuestions
    private static let technologyQuestions: [QuizQuestion] = technologyBaseQuestions + technologyExtraQuestions
    private static let sportsQuestions: [QuizQuestion] = sportsBaseQuestions + sportsExtraQuestions
    private static let generalKnowledgeQuestions: [QuizQuestion] = generalKnowledgeBaseQuestions + generalKnowledgeExtraQuestions

    static let defaultQuestions: [QuizQuestion] = historyQuestions
        + biologyQuestions
        + technologyQuestions
        + sportsQuestions
        + generalKnowledgeQuestions

    static func questions(for category: QuestionCategory) -> [QuizQuestion] {
        switch category {
        case .all:
            return defaultQuestions
        case .history:
            return historyQuestions
        case .biology:
            return biologyQuestions
        case .technology:
            return technologyQuestions
        case .sports:
            return sportsQuestions
        case .generalKnowledge:
            return generalKnowledgeQuestions
        }
    }
}
