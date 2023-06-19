# Einleitung:
In der App von CardsToLearn handelt es sich um eine Lernapp. Der Nutzer soll die möglichkeit haben sein eigenen Lehrinhalt zu gestalten,
aufgrund der Funktionen wie Create a Flashcard ,womit er dann sein eigenen Quiz spielen kann und sich somit den Inhalt besser einprägen kann.
Ebenfalls kann der Nutzer durch die QuizCreationView sein eigenes Quiz erstellen, indem er die Kategoriennamen , fragen und 4 möglichen antworten
eingeben kann und auswählt welche richtig ist. Und somit kann er sein eigenen erstellten Quiz spielen. 
Außerdem wird dem Nutzer durch eine Api ,ein englisches Quiz zur verfügung gestellt womit er seine Englisch Skills verbessern kann . 
Zustätzlich gibt es keine englische Dicitonary funktion , die ebenfalls von einer Api stammt, nach englischen begriffen suchen kann und
ihre Definitionen erfahren kann.
Ebenfalls gibt es eine englische Quotes funktion die ebenfalls von einer Api stammt. Hier kann er nach Zitaten suchen die aber an 
bestimmten Kategorien verknüpft sind.![SplashScreen](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/0cf2424a-f18f-4611-ba24-65b89a0118c8)



# Login/SignUp:
Nach dem Splashscreen erscheint das LoginView. Wenn man unten rechts auf das X klickt erscheint das SignUpView, wo man die Möglichkeit 
hat sich zu registrieren. Die Login und SignUp daten werden in Firebase gespeichert. Nachdem man sich erfolgreich eingeloggt hat, erscheint
das Home Menü.![LoginSignUp](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/6c795e4e-6562-4a44-bd12-bd49d85288af)


# HomeMenu:
Im HomeMenu kann man sich Notizen für die aktuelle Woche eintragen lässen, wenn man auf das Plus Icon klickt. Man hat auch die Möglichkeit
die Notizen wieder zu bearbeiten oder zu löschen. ![Task](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/4e4ea9e3-9e15-4b2f-922a-849cd470f307)
![Task2](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/a3872910-6345-4cbe-918e-f39ab2e27d58)
Wenn man auf das obere linke Bild(User) klickt zeigt es ein SideBaseHomeMenu an , man hat aber auch die Möglichkeit rüber zu Swipen ,
unabhängig davon in welcher View man sich befindet.![SideBaseMenu](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/92b43dcf-7192-4ba6-8299-451dff6eea2b)
In der SideBaseHomeMenu befinden sich kleine Informationen wie Profildaten, Letze Karte die erstellt wurde, das letzte Quiz das gespielt wurde,
die Favoriten, Aktivitäten, Statistik usw. 
Einige Views wurden fertig bearbeitet und die restlichen werden in der Zukunft noch bearbeitet.![SideBaseMenuInfo](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/05808654-8e4e-4aad-85a5-feb1087e0d6d)


# QuotesTab:
Das Quotes icon im TabView zeigt 4 verschieden Views an. Der Nutzer kriegt einige Motivationssprüche , wenn er zu einer demotivierten
Phase übergeht und er hat auch noch 7 Lerntipps, wenn er Probleme hat gewissen Themen zu verstehen.

![LearnTips](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/418fa880-83c5-4c85-9034-071e57ebf359)
![Motivation](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/b829b378-27d2-4295-acf4-d2894fbb1d1e)

Ebenfalls befindet sich in der QuotesTab die DictionayView und QuotesView die beide eine Api bestizen.![Dictionary Quotes](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/8c66e3f8-91c9-436b-91a8-5b9a1b98d42f)


# CardsTab:
Das Card icon im Tabview alle Flashcards an die man erstellt hat. Wenn man auf den Schriftzug "MyCards" klickt werden alle Karten angezeigt. 
Die Tags sind die Katgeorienamen, sobald man raufklickt werden nur die Karten der jeweiligen Kategorien angezeigt.
![Cards](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/8eecc292-387f-41a7-b1c4-6761bb3e9ec4)
![HomCards](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/9d0d8dc1-c826-471b-9a92-65512b869be1)

Durch das Plus icon kann man die Flashcards erstellen und speichern, was durch CoreData ermöglicht wird. 
![CreateCard](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/9051a81c-2aa2-4864-b92f-2c8beb988530)

Klickt man auf eine ausgewählte Karte wird nur die Frage angezeigt und die Antwort versteckt, jedoch beim klicken des Show Answer Button 
und andersrum mit Show Question wird die Antwort/Frage angezeigt.![CardDetail](https://github.com/CaglayanCosgun/CardsToLearn/assets/115452046/c817099d-4327-480b-a145-e5ed75589e57)
