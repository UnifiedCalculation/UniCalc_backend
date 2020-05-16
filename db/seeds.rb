# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Delete ALL old data
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

# Create roles
Role.create name: "Admin"
Role.create name: "Verkäufer"
Role.create name: "Projektleiter"
Role.create name: "Mitarbeiter"

# Create dummy admin user and customer
user = User.create email: "admin@example.com", password: "123456", password_confirmation: "123456", firstname: "Admin", lastname: "Admin"
user.roles << Role.first
company = Company.create name: "Example AG", url: "example.com", address: "Examplestreet 123", city: "Zurich", zip: "8000", phone: "+41 11 234 56 78", mail: "info@examplecompany.ch"
Employee.create user: user, company: company

customer_user = User.create email: "customer@example.com", password: "123456", password_confirmation: "123456", firstname: "Example", lastname: "Customer"
Customer.create user: customer_user, company: company, address: "Examplestreet 333", city: "Zurich", zip: "8000", phone: "+41 11 234 56 78"

# Create NPK
parent = Npk.create number: 0, name: "Kosten für Grundstück"
Npk.create number: 10, name: "Vorstudien", npk: parent
Npk.create number: 20, name: "Grundstücks- und Baurechtserwerbskosten", npk: parent
Npk.create number: 30, name: "Nebenkosten zu Grundstück- und Baurechtserwerb", npk: parent
Npk.create number: 40, name: "Abfindungen, Servitute, Beiträge", npk: parent
Npk.create number: 50, name: "Betriebskosten und -erträge", npk: parent
Npk.create number: 90, name: "Eigene Kapitel der Anwender", npk: parent
parent = Npk.create number: 51, name: "Betriebskosten"
parent = Npk.create number: 52, name: "Betriebserträge"
parent = Npk.create number: 100, name: "Vorbereitung, Spezialtiefbau, Instandsetzung, Umgebung"
Npk.create number: 102, name: "Besondere Bestimmungen", npk: parent
Npk.create number: 103, name: "Kostengrundlagen", npk: parent
Npk.create number: 110, name: "Vorbereitungs-, Rodungs- und Abbrucharbeiten", npk: parent
Npk.create number: 111, name: "Regiearbeiten", npk: parent
Npk.create number: 112, name: "Prüfungen", npk: parent
Npk.create number: 113, name: "Baustelleneinrichtung", npk: parent
Npk.create number: 114, name: "Arbeitsgerüste", npk: parent
Npk.create number: 115, name: "Baugrundsondierungen", npk: parent
Npk.create number: 116, name: "Holzen und Roden", npk: parent
Npk.create number: 117, name: "Abbrüche und Demontagen", npk: parent
parent = Npk.create number: 120, name: "Bauwerksicherungsarbeiten"
Npk.create number: 121, name: "Sichern, unterfangen, verstärken und verschieben", npk: parent
Npk.create number: 124, name: "Hilfsbrücken", npk: parent
Npk.create number: 125, name: "Temporäre Verkehrsführung", npk: parent
parent = Npk.create number: 130, name: "Instandsetzungsarbeiten"
Npk.create number: 131, name: "Instandsetzung und Schutz von Betonbauten", npk: parent
Npk.create number: 132, name: "Bohren und Trennen von Beton und Mauerwerk", npk: parent
Npk.create number: 133, name: "Instandsetzung und Schutz von Mauerwerk aus Natursteinen", npk: parent
Npk.create number: 135, name: "Instandhaltung und Sanierung von Abwassersystemen", npk: parent
parent = Npk.create number: 150, name: "Bauarbeiten für erdverlegte Leitungen"
Npk.create number: 151, name: "Bauarbeiten für Werkleitungen", npk: parent
Npk.create number: 152, name: "Rohrvortrieb", npk: parent
Npk.create number: 153, name: "Uebertragungsleitungen", npk: parent
Npk.create number: 154, name: "Fahrleitungen", npk: parent
Npk.create number: 155, name: "Kabelzüge und Spleissungen", npk: parent
parent = Npk.create number: 160, name: "Baugrubensicherungen und Wasserhaltung"
Npk.create number: 161, name: "Wasserhaltung", npk: parent
Npk.create number: 162, name: "Baugrubenabschlüsse und Aussteifungen", npk: parent
Npk.create number: 164, name: "Verankerungen und Nagelwände", npk: parent
parent = Npk.create number: 170, name: "Spezialfundationen und Grundwasserabdichtungsarbeiten"
Npk.create number: 171, name: "Pfähle", npk: parent
Npk.create number: 172, name: "Abdichtungen für Bauwerke unter Terrain und für Brücken", npk: parent
Npk.create number: 173, name: "Baugrundverbesserungen", npk: parent
parent = Npk.create number: 180, name: "Umgebungsarbeiten"
Npk.create number: 181, name: "Garten- und Landschaftsbau", npk: parent
Npk.create number: 182, name: "Einrichtungen für Spielplätze und Sportanlagen", npk: parent
Npk.create number: 183, name: "Zäune und Arealeingänge", npk: parent
Npk.create number: 184, name: "Pflege von Grün- und Freiflächen", npk: parent
Npk.create number: 185, name: "Gebäudebegrünung", npk: parent
Npk.create number: 186, name: "Friedhofarbeiten", npk: parent
Npk.create number: 187, name: "Sportbeläge für Freianlagen und Hallen", npk: parent
Npk.create number: 188, name: "Lärmschutzwände", npk: parent
parent = Npk.create number: 190, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 200, name: "Tiefbau- und Untertagbauarbeiten"
parent = Npk.create number: 210, name: "Erdbauarbeiten"
Npk.create number: 211, name: "Baugruben und Erdbau", npk: parent
Npk.create number: 213, name: "Wasserbau", npk: parent
Npk.create number: 214, name: "Lawinen- und Steinschlagverbau", npk: parent
Npk.create number: 216, name: "Altlasten, belastete Standorte und Entsorgung", npk: parent
parent = Npk.create number: 220, name: "Oberbauarbeiten"
Npk.create number: 221, name: "Fundationsschichten für Verkehrsanlagen", npk: parent
Npk.create number: 222, name: "Abschlüsse, Pflästerungen, Plattendecken und Treppen", npk: parent
Npk.create number: 223, name: "Belagsarbeiten", npk: parent
Npk.create number: 225, name: "Gleisbau, Sicherungsanlagen und Weichenheizungen", npk: parent
Npk.create number: 226, name: "Materialaufbereitung", npk: parent
Npk.create number: 228, name: "Zusammengefasste Leistungen im Strassen- und Leitungsbau", npk: parent
parent = Npk.create number: 230, name: "Trassebau: Entwässerung, Kanalisation, Leitungsarbeiten"
Npk.create number: 237, name: "Kanalisationen und Entwässerungen", npk: parent
parent = Npk.create number: 240, name: "Rohbauarbeiten für Kunstbauten"
Npk.create number: 241, name: "Ortbetonbau", npk: parent
Npk.create number: 244, name: "Lager- und Fahrbahnübergänge für Brücken", npk: parent
Npk.create number: 246, name: "Spannsysteme", npk: parent
Npk.create number: 247, name: "Lehr-, Schutz- und Montagegerüste", npk: parent
parent = Npk.create number: 260, name: "Ausbruchsarbeiten unter Tag"
Npk.create number: 261, name: "Sprengvortrieb im Fels SPV", npk: parent
Npk.create number: 262, name: "Tunnelbohrmaschinen-Vortrieb im Fels TBM", npk: parent
Npk.create number: 263, name: "Maschinenunterstützter Vortrieb im Fels MUF", npk: parent
Npk.create number: 264, name: "Maschinenunterstützter Vortrieb im Lockergestein MUL", npk: parent
Npk.create number: 265, name: "Schildmaschinen-Vortrieb im Lockergestein SM", npk: parent
Npk.create number: 266, name: "Ausbruchsicherungen im Untertagbau", npk: parent
Npk.create number: 267, name: "Bauhilfsmassnahmen im Untertagbau", npk: parent
Npk.create number: 268, name: "Wasserhaltung im Untertagbau", npk: parent
parent = Npk.create number: 270, name: "Ausbauarbeiten unter Tag"
Npk.create number: 271, name: "Abdichtungen im Untertagbau", npk: parent
Npk.create number: 272, name: "Entwässerungen im Untertagbau", npk: parent
Npk.create number: 273, name: "Verkleidungen im Untertagbau", npk: parent
Npk.create number: 274, name: "Innenausbau im Untertagbau", npk: parent
Npk.create number: 275, name: "Kabelrohranlagen im Untertagbau", npk: parent
Npk.create number: 276, name: "Vorauserkundungen und Ueberwachungen im Untertagbau", npk: parent
parent = Npk.create number: 280, name: "Ausbauarbeiten für Trasse-, Kunst-, und Untertagebauten"
Npk.create number: 281, name: "Fahrzeug- Rückhaltesysteme und Geländer", npk: parent
Npk.create number: 282, name: "Signalisierung: Strassensignale", npk: parent
Npk.create number: 283, name: "Signalisierung: Grossflächentafeln", npk: parent
Npk.create number: 284, name: "Signalisierung: Verkehrsbeeinflussungsanlagen", npk: parent
Npk.create number: 286, name: "Markierung auf Verkehrsflächen", npk: parent
parent = Npk.create number: 290, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 300, name: "Rohbauarbeiten"
parent = Npk.create number: 310, name: "Baumeisterarbeiten"
Npk.create number: 314, name: "Maurerarbeiten", npk: parent
Npk.create number: 315, name: "Vorgefertigte Elemente aus Beton und künstlichen Steinen", npk: parent
Npk.create number: 318, name: "Spezielle Dichtungen und Dämmungen", npk: parent
parent = Npk.create number: 320, name: "Stahlbauarbeiten"
Npk.create number: 321, name: "Montagebau in Stahl", npk: parent
Npk.create number: 324, name: "Schutzraumteile", npk: parent
parent = Npk.create number: 330, name: "Zimmerarbeiten"
Npk.create number: 331, name: "Zimmerarbeiten: Tragkonstruktion", npk: parent
Npk.create number: 332, name: "Elementbau in Holz", npk: parent
Npk.create number: 333, name: "Holzbau: Bekleidungen und Ausbau", npk: parent
Npk.create number: 334, name: "Treppen", npk: parent
parent = Npk.create number: 340, name: "Bekleidungsarbeiten im Hochbau"
Npk.create number: 342, name: "Verputzte Aussenwärmedämmung", npk: parent
Npk.create number: 343, name: "Hinterlüftete Fassadenbekleidungen", npk: parent
Npk.create number: 344, name: "Fassadenbau", npk: parent
Npk.create number: 345, name: "Natursteinarbeiten", npk: parent
Npk.create number: 346, name: "Kunststeinarbeiten", npk: parent
Npk.create number: 347, name: "Sonnen- und Wetterschutzanlagen", npk: parent
Npk.create number: 348, name: "Aussenputze", npk: parent
parent = Npk.create number: 350, name: "Spenglerarbeiten"
Npk.create number: 351, name: "Spenglerarbeiten: Dachentwässerungen und Anschlussbleche", npk: parent
Npk.create number: 352, name: "Spenglerarbeiten: Deckungen und Bekleidungen aus Dünnblech", npk: parent
Npk.create number: 357, name: "Blitzschutzanlagen aussen", npk: parent
parent = Npk.create number: 360, name: "Bedachungsarbeiten"
Npk.create number: 361, name: "Geneigte Dächer: Vorarbeiten, Rückbau und Instandsetzung", npk: parent
Npk.create number: 362, name: "Abdichtungen von befahrbaren Flächen im Hochbau", npk: parent
Npk.create number: 363, name: "Geneigte Dächer: Unterkonstruktionen und Deckungen", npk: parent
Npk.create number: 364, name: "Flachdacharbeiten", npk: parent
Npk.create number: 365, name: "Verglaste Einbauten in Dächern", npk: parent
Npk.create number: 367, name: "Absturzsicherungen für Unterhalt und Kontrolle auf Dächern", npk: parent
Npk.create number: 368, name: "Photovoltaik- und thermische Solaranlagen", npk: parent
parent = Npk.create number: 370, name: "Fenster"
Npk.create number: 371, name: "Fenster und Fenstertüren", npk: parent
Npk.create number: 376, name: "Anlagen aus Glas und Metall", npk: parent
Npk.create number: 378, name: "Profilbaugläser, Glassteine, Betongläser (Glasbausteine)", npk: parent
parent = Npk.create number: 380, name: "Aussentüren und Tore"
Npk.create number: 381, name: "Holzbau: Türen und Tore", npk: parent
Npk.create number: 384, name: "Tore", npk: parent
Npk.create number: 388, name: "Schliessanlagen", npk: parent
parent = Npk.create number: 390, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 400, name: "Sanitär-, Heizungs-, Lüftungs- und Klimaanlagen"
Npk.create number: 402, name: "Sanitäranlagen: Anlagebeschreibung", npk: parent
Npk.create number: 405, name: "Heizungsanlagen: Anlagebeschreibung", npk: parent
Npk.create number: 406, name: "Raumlufttechnische Anlagen: Anlagebeschreibung", npk: parent
parent = Npk.create number: 410, name: "Erdverlegte Leitungen"
Npk.create number: 411, name: "Werkleitungen für Wasser und Gas", npk: parent
Npk.create number: 414, name: "Leitungen und Armaturen für Fernwärme und Fernkälte", npk: parent
parent = Npk.create number: 420, name: "Sanitärinstallationen"
Npk.create number: 422, name: "Versorgungsapparate", npk: parent
Npk.create number: 423, name: "Entsorgungsapparate", npk: parent
Npk.create number: 426, name: "Sanitäranlagen: Versorgungsleitungen", npk: parent
Npk.create number: 427, name: "Sanitäranlagen: Entsorgung", npk: parent
parent = Npk.create number: 450, name: "Heizungsinstallationen"
Npk.create number: 451, name: "Heizungsanlagen: Wärmeerzeugung", npk: parent
Npk.create number: 452, name: "Heizungsanlagen: Wärmeabgabe", npk: parent
Npk.create number: 453, name: "Heizungsanlagen: Rohrleitungen", npk: parent
Npk.create number: 454, name: "Heizungsanlagen: Armaturen", npk: parent
Npk.create number: 455, name: "Heizungsanlagen: Apparate", npk: parent
Npk.create number: 456, name: "Heizungsanlagen: Messen, Steuern, Regeln", npk: parent
Npk.create number: 457, name: "Heizungsanlagen: Brennstofflagerung", npk: parent
Npk.create number: 458, name: "Heizungsanlagen: Kamine und Abgasleitungen", npk: parent
parent = Npk.create number: 460, name: "Raumlufttechnische Anlagen"
Npk.create number: 461, name: "Raumlufttechnische Anlagen: Luftaufbereitungsgeräte", npk: parent
Npk.create number: 463, name: "Raumlufttechnische Anlagen: Einzelkomponenten", npk: parent
Npk.create number: 464, name: "Raumlufttechnische Anlagen: Luftleitungen", npk: parent
Npk.create number: 465, name: "Raumlufttechnische Anlagen: Luftdurchlässe", npk: parent
Npk.create number: 466, name: "Raumlufttechnische Anlagen: Armaturen", npk: parent
Npk.create number: 467, name: "Kühldecken, Kühlbalken", npk: parent
Npk.create number: 468, name: "Raumlufttechnische Anlagen: Messen, Steuern, Regeln", npk: parent
Npk.create number: 481, name: "Dämmungen für Rohrleitungen und Kanäle", npk: parent
parent = Npk.create number: 480, name: "﻿Dämmungen für Sanitär- und Heizungsanlagen﻿"
parent = Npk.create number: 490, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 500, name: "Elektro und Telekommunikation"
Npk.create number: 501, name: "Elektroanlagen: Anlagebeschreibung", npk: parent
Npk.create number: 502, name: "Elektroanlagen: Ausführungsbedingungen Elektro", npk: parent
parent = Npk.create number: 510, name: "Allgemeine Bestimmungen, Leitungsführung"
Npk.create number: 511, name: " Regiearbeiten und Vorhalten", npk: parent
Npk.create number: 512, name: "Rohre, Schlaufkästen und Befestigungsmittel", npk: parent
Npk.create number: 513, name: "Installations- und Brüstungskanäle", npk: parent
Npk.create number: 514, name: "Kabeltragsysteme, Bodenkanäle und Abschottungen", npk: parent
parent = Npk.create number: 520, name: "Leiter"
Npk.create number: 521, name: "Erder, Potenzialausgleich und Blitzschutz", npk: parent
Npk.create number: 522, name: "Kabel, Drähte und Stromschienen (E)", npk: parent
Npk.create number: 526, name: "Kabel und Drähte (T)", npk: parent
parent = Npk.create number: 530, name: "Schaltgerätekombinationen, Leergehäuse"
Npk.create number: 531, name: "Schaltgerätekombinationen, Leergehäuse (E)", npk: parent
parent = Npk.create number: 540, name: "Apparate für Starkstrom"
Npk.create number: 541, name: "Abzweigkästen und Kabelmuffen (E)", npk: parent
Npk.create number: 542, name: "Schalter und Steckdosen (E)", npk: parent
Npk.create number: 543, name: "Schalt- und Schutzapparate (E)", npk: parent
parent = Npk.create number: 550, name: "Apparate für Schwachstrom"
Npk.create number: 551, name: "Verteiler, Abzweigkästen, Steckdosen und Kabelmuffen (T)", npk: parent
Npk.create number: 552, name: "Hauskommunikation (T)", npk: parent
Npk.create number: 553, name: "Audio, Video, Radio und TV (T)", npk: parent
Npk.create number: 554, name: "Ueberwachung und Alarmierung (T)", npk: parent
Npk.create number: 556, name: "Zeiterfassung und Uhren (T)", npk: parent
Npk.create number: 557, name: "Telekommunikationsgeräte, Aktivkomponenten und dgl. (T)", npk: parent
parent = Npk.create number: 560, name: "Gebäudeautomation"
Npk.create number: 561, name: "GA: KNX", npk: parent
Npk.create number: 563, name: "GA: Proprietäre Systeme", npk: parent
Npk.create number: 565, name: "GA: SPS", npk: parent
parent = Npk.create number: 570, name: "Energieverbraucher"
Npk.create number: 573, name: "Haushaltgeräte, Heizungen, Motoren und dgl. (E)", npk: parent
Npk.create number: 574, name: "Beleuchtung (E)", npk: parent
parent = Npk.create number: 580, name: "Installationsteile"
Npk.create number: 583, name: "Installationsteile für Zweckbauten (E)", npk: parent
Npk.create number: 584, name: "Installationsteile für Zweckbauten (T)", npk: parent
Npk.create number: 585, name: "Installationsteile für Wohnungsbau (E)", npk: parent
Npk.create number: 586, name: "Installationsteile für Wohnungsbau (T)", npk: parent
parent = Npk.create number: 590, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 600, name: "Ausbauarbeiten"
parent = Npk.create number: 610, name: "Metallbauarbeiten"
Npk.create number: 611, name: "Fensterbänke, Fensterzargen, Metallfertigteile Ausbau", npk: parent
Npk.create number: 612, name: "Allgemeine Metallbauarbeiten", npk: parent
parent = Npk.create number: 620, name: "Schreinerarbeiten"
Npk.create number: 621, name: "Schränke aus Holz und Holzwerkstoffen", npk: parent
Npk.create number: 622, name: "Türen", npk: parent
Npk.create number: 624, name: "Allgemeine Schreinerarbeiten", npk: parent
Npk.create number: 625, name: "Haushaltküchen", npk: parent
parent = Npk.create number: 630, name: "Trennwände"
Npk.create number: 631, name: "Trennwände", npk: parent
parent = Npk.create number: 640, name: "Bekleiduung und Plattenarbeiten"
Npk.create number: 642, name: "Wandverkleidungen in Holz und Holzwerkstoffen", npk: parent
Npk.create number: 644, name: "Brandschutz: Bekleidungen, Beschichtungen und Abschottungen", npk: parent
Npk.create number: 645, name: "Plattenbeläge", npk: parent
Npk.create number: 646, name: "Hafnerarbeiten (Cheminées und Oefen)", npk: parent
parent = Npk.create number: 643, name: "Trockenbauarbeiten: Wände"
parent = Npk.create number: 650, name: "Deckenbekleidungen"
Npk.create number: 651, name: "Deckenbekleidungen aus Trockenbauplatten", npk: parent
Npk.create number: 652, name: "Deckenbekleidungen aus Holz, Holzwerkstoffen, Mineralfasern", npk: parent
Npk.create number: 653, name: "Deckenbekleidungen aus Metall", npk: parent
parent = Npk.create number: 660, name: "Bodenbeläge"
Npk.create number: 661, name: "Estriche schwimmend oder im Verbund", npk: parent
Npk.create number: 662, name: "Bodenbeläge aus Zement, Magnesia, Kunstharz und Bitumen", npk: parent
Npk.create number: 663, name: "Beläge aus Linoleum, Kunststoffen, Textilien und dgl.", npk: parent
Npk.create number: 664, name: "Bodenbeläge aus Holz, Kork, Laminat und dgl.", npk: parent
Npk.create number: 665, name: "Doppel- und Verbunddoppelböden", npk: parent
Npk.create number: 666, name: "Sockelleisten und dgl.", npk: parent
Npk.create number: 667, name: "Hohlraumböden", npk: parent
parent = Npk.create number: 670, name: "Oberflächenbehandlungen"
Npk.create number: 671, name: "Gipserarbeiten: Innenputze und Stuckaturen", npk: parent
Npk.create number: 675, name: "Maler-, Tapezierer- und Holzbeizarbeiten innen", npk: parent
Npk.create number: 676, name: "Malerarbeiten aussen", npk: parent
parent = Npk.create number: 680, name: "Reinigungsarbeiten"
Npk.create number: 681, name: "Bauheizung, Bautrocknung und Baulüftung", npk: parent
Npk.create number: 682, name: "Baureinigung", npk: parent
Npk.create number: 683, name: "Unterhaltsreinigungen", npk: parent
parent = Npk.create number: 690, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 700, name: "Einrichtungs-, Ausrüstungs- und Ausstattungsarbeiten"
parent = Npk.create number: 730, name: "Landwirtschaftliche Ausstattungen"
Npk.create number: 731, name: "Landwirtschaftliche Betriebseinrichtungen", npk: parent
parent = Npk.create number: 740, name: "Transportanlagen"
Npk.create number: 742, name: "Standardaufzüge für Wohnbauten", npk: parent
Npk.create number: 743, name: "Aufzüge für Geschäftshäuser, Hotels und Krankenhäuser", npk: parent
Npk.create number: 744, name: "Lastenaufzüge mit Personenbegleitung", npk: parent
Npk.create number: 745, name: "Kleingüteraufzüge", npk: parent
Npk.create number: 746, name: "Fahrtreppen und Fahrsteige", npk: parent
Npk.create number: 747, name: "Hubtische, Verladestationen und Spezialaufzüge", npk: parent
Npk.create number: 761, name: "Parkieranlagen", npk: parent
parent = Npk.create number: 760, name: "﻿Lageranlagen﻿"
parent = Npk.create number: 770, name: "Gebäudeausstattungen"
Npk.create number: 771, name: "Vorhänge und Innendekorationsarbeiten", npk: parent
Npk.create number: 772, name: "Schutzräume und -anlagen ZS: Einrichtung und Ausstattung", npk: parent
Npk.create number: 774, name: "Brandschutzeinrichtungen", npk: parent
Npk.create number: 776, name: "Metallbaufertigteile: Ausstattungen", npk: parent
parent = Npk.create number: 780, name: "Gebäudeautomation"
Npk.create number: 781, name: "GA: Allgemeine Arbeiten", npk: parent
Npk.create number: 782, name: "GA: Managementsystem", npk: parent
Npk.create number: 783, name: "GA: Anlagenautomation", npk: parent
Npk.create number: 784, name: "GA: Raumautomation", npk: parent
parent = Npk.create number: 790, name: "Eigene Kapitel der Anwender"
parent = Npk.create number: 800, name: "Uebrige Aufwendungen"
Npk.create number: 810, name: "Wettbewerbe und Kunst am Bau", npk: parent
Npk.create number: 820, name: "Bewilligungen und Gebühren", npk: parent
Npk.create number: 830, name: "Baunebenkosten", npk: parent
Npk.create number: 840, name: "Vergütungen an Dritte", npk: parent
Npk.create number: 850, name: "Bauherrenleistungen", npk: parent
Npk.create number: 860, name: "Finanzierung", npk: parent
Npk.create number: 870, name: "Honorare", npk: parent
Npk.create number: 880, name: "Uebergangskosten", npk: parent
Npk.create number: 890, name: "Eigene Kapitel der Anwender", npk: parent
parent = Npk.create number: 900, name: "Eigene Kapitel der Anwender"
Npk.create number: 910, name: "Vorbereitung, Spezialtiefbau, Instandsetzung, Umgebung", npk: parent
Npk.create number: 920, name: "Trasse-, Kunst- und Untertagbauarbeiten", npk: parent
Npk.create number: 930, name: "Rohbauarbeiten", npk: parent
Npk.create number: 940, name: "Arbeiten für Sanitär, Heizung, Lüftung, Klima und Transport", npk: parent
Npk.create number: 950, name: "Arbeiten für Elektroanlagen und Informatik", npk: parent
Npk.create number: 960, name: "Ausbau- und Reinigungsarbeiten", npk: parent
Npk.create number: 970, name: "Einrichtungs-, Ausrüstungs- und Ausstattungsarbeiten", npk: parent
