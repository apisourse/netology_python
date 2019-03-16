--A350 : change list for Fin category

delete from t_choicelist where ChoiceList = 'FINCategory'
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','AIRLINES SPARE ASSEMBLY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','DATA TABLE')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','EQUIPMENT MOUNTED IN A DASSY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','FIN IN PRIMARY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','FIN PCD TYPE')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','FIN POSITION')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','FIN SW SPP')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LIGHTED PLATE XXXX VU')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LOAD GROUP')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LRI')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LRU')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LRU IN A SUBCONTRACTED CA')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','LRU IN MASTER FIN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','MASTER FIN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','MULTIPLE QUANTITY FIN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','PCD FUNCTION')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','PHANTOM FIN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','PRIMARY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','STANDARD ITEM')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','SW APPROVED UPLOADED BY AIRBUS')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','SW CERTIF UPLOADED BY AIRBUS')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','SW CERTIF UPLOADED BY EXTERN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FINCategory','SW CUSTOMER EMPTY')


-- Change list for FLS fin category
delete from t_choicelist where ChoiceList = 'FLS Category'
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','FIN IN PRIMARY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','FIN POSITION')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','FIN SW SPP')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','LRI')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','LRU')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','LRU IN A SUBCONTRACTED CA')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','PRIMARY')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','SW APPROVED UPLOADED BY AIRBUS')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','SW CERTIF UPLOADED BY AIRBUS')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','SW CERTIF UPLOADED BY EXTERN')
insert into t_choicelist (choicelist,choiceValue) VALUES ('FLS Category','SW CUSTOMER EMPTY')
