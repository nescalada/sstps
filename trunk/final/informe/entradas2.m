y = [
0.010122261518670683
7.311442651687372E-4
0.009959576965639982
0.00980028261162147
0.01414238654433042
0.020802688623019705
0.020813547967211576
0.0188519026490912
0.019478656408189465
0.006572106022650459
0.012482125426041435
0.0038074397803704585
0.019377339525860293
0.01760545926949142
0.013011008878098806
6.762088348697404E-4
0.0026856859678598966
0.009435545758670116
0.004302017708210926
0.010404994705879744
0.004811088788210682
0.01354672366643861
0.01630033962984001
0.0214131649122713
0.014116642530590084
0.020536798145959878
0.006193567110470255
0.00809261739473044
0.004509188928539132
0.007422396066710135
0.02103260222646952
0.005760285353570538
3.6907649510098395E-4
0.02074340392559826
0.019752006044761572
0.0021803464163401287
0.0015659545011796894
0.0069507013391501005
0.01672547492958998
0.0034211794029594955
0.02381004316160862
0.028971103605980986
0.025365182635381345
0.025131538834008538
0.022584858555909193
0.03084625526097895
0.02362881217555035
0.03305801332945002
0.03902201546232931
0.02702268881504999
0.03374513128076906
0.022455709510989408
0.03437060253668989
0.04344260789621934
0.038161856442920694
0.03585729108061919
0.031614052422201055
0.03446330257614072
0.04311441975912089
0.02854171028677044
0.032741662345840084
0.03254057205363914
0.06220618426211999
0.05849431595448884
0.058997177508759435
0.048431316182369955
0.06428902890549004
0.057929263985361246
0.06506872849482015
0.0539105732967986
0.049265170283518955
0.0705228912162088
0.06673978807855896
0.07707427940787959
0.08481420174365972
0.07410641659263995
0.08219207080749058
0.07732464420868901
0.0737941715986512
0.08537560499007846
0.08254796963273847
0.08243716208211005
0.06918034252804972
0.08850700990715055
0.10898306286238935
0.09277455759179887
0.10513806052337138
0.1098138541153606
0.09931967318432022
0.12996775487135892
0.13248727834766072
0.1299892093861903
0.12556435628509988
0.16677052833156125
0.1870215425023396
0.18082497640997097
0.21043951968781016
0.20267157264396118
0.21756323278104972
0.22143299625055946
];

disp('mediana: ')
median(y)
disp(' desvio standard: ')
std(y)
disp('varianza: ')
var(y)
disp('media: ')
mean(y)

hist(y, 7, max(size(y)))