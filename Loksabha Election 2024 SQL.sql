
SELECT * FROM constituencywise_details

SELECT * FROM constituencywise_results

SELECT * FROM partywise_results

SELECT * FROM states

SELECT * FROM statewise_results

-- 1) How many total seats are there ?

SELECT
  DISTINCT COUNT
      (parliament_constituency)Total_seats 
FROM 
       constituencywise_results

-- 2) What are the total number of seats available in each state ?


SELECT 
   s.state as State_name ,
   COUNT
      (cr.parliament_constituency)Total_seats
FROM 
   constituencywise_results cr 
JOIN 
   statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
   states s ON sr.State_ID = s.State_ID
GROUP BY 
   s.state

-- 3) Total Seats won by NDA Alliance 

SELECT
  SUM(CASE  
     WHEN Party IN(
	            'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
       Then [WON]
     ELSE 0
	END) as NDA_Total_Votes
  FROM partywise_results

 --4) Total seats won by NDA Allaince parties

SELECT 
   Party as Party_Name, 
   Won as Seat_Won
FROM 
   partywise_results 
WHERE 
   Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'     
)
ORDER BY seat_won DESC


-- 4) Total Seats won by I.N.D.I.A Alliance 

SELECT 
  SUM(CASE
        WHEN Party IN (
                       'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
            THEN WON
		   ELSE 0
		  END) AS INDIA_Total_Seats_Won
      FROM partywise_results

  --5) Total seats won by INDIA Allaince  and NDA allaince parties .
 
  
SELECT 
  party_allaince ,SUM(WON) as Seats
FROM 
  partywise_results
GROUP BY  
  party_allaince 

  --  OR

SELECT 
   Party as Party_Name, 
   Won as Seat_Won
FROM 
   partywise_results 
WHERE 
   Party IN (    
                 'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
)
ORDER BY seat_won DESC 
 
-- 6) Add a new colunm as a party Allaince to know weather the comes under NDA, INDIA Or Others.
 
ALTER Table partywise_results
ADD party_allaince VARCHAR(50)

UPDATE partywise_results 
SET party_allaince  = 'I.N.D.I.A'
WHERE Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')


UPDATE 
  partywise_results 
SET 
  party_allaince  = 'NDA'
WHERE 
   Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM' )


UPDATE 
  partywise_results 
SET 
  party_allaince  = 'Others'
WHERE 
  party_allaince IS NULL


SELECT party_allaince ,SUM(WON) as Seats
FROM partywise_results
GROUP BY  party_allaince 


-- 7) Fetch out the winning candidate name ,their party name, total votes and the margin of victory
--    for a specific state ans constituency

SELECT 
    cr.winning_candidate,
    pr.party,
	pr.party_allaince,
	cr.total_votes,
	cr.margin,
	s.state,
	sr.constituency
FROM 
    constituencywise_results CR
JOIN 
    partywise_results pr ON cr.party_id = pr.party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
WHERE 
    Constituency_Name   = 'KANPUR'


-- 8)  What is the distribution of EVM votes VS postal votes for canditates in a specific constituency 

SELECT cd.candidate,
       cd.Evm_votes,
       cd.postal_votes,
       cd.total_votes,
	   cr.constituency_name
FROM 
  constituencywise_results cr
   INNER JOIN constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
WHERE 
  constituency_name = 'BIJNOR'

-- 9) Which party won the most seats in a state , and how many seats did each party win ?

SELECT 
     p.party, 
	 COUNT(cr.Constituency_Name)seats_won 
FROM 
     constituencywise_results cr
INNER JOIN 
     partywise_results p  ON cr.Party_ID = p.party_id
INNER JOIN	
     statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN 
     states s ON sr.State_ID = s.State_ID
WHERE 
     s.State = 'Punjab'
GROUP BY 
     p.party
ORDER BY 
     seats_won DESC


--9) What is the total number of seats won by each party allaince (NDA, I.N.D.I.A. Others)
--   in each state for indian Election 2024

SELECT
   s.state ,
   SUM(CASE WHEN p.party_allaince = 'NDA' THEN 1 ELSE 0 END)AS NDA_Seats_Won,
   SUM(CASE WHEN p.party_allaince = 'INDIA' THEN 1 ELSE 0 END)AS INDIA_Seats_Won,
   SUM(CASE WHEN p.party_allaince = 'Others' THEN 1 ELSE 0 END)AS Others_Seats_Won
FROM 
   constituencywise_results cr 
JOIN
   partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
   statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
   states s ON sr.State_ID = s.State_ID
GROUP BY
   s.State


-- 10) Which candidate receive the higest no of EVM Votes in each constituency ? TOP 10 
--     mention their party allaince also. 

SELECT TOP 10
    cr.constituency_name,
	cd.constituency_id,
	cd.candidate,
	cd.evm_votes,
	p.party_allaince
FROM
    constituencywise_details cd
JOIN
    constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    cd.EVM_Votes = (
      SELECT 
	      MAX(cd1.evm_votes)
	  FROM
	      constituencywise_details cd1
	  WHERE 
	      cd1.Constituency_ID = cd.Constituency_ID  
	   )
ORDER BY 
    cd.EVM_Votes DESC


-- 11) For Maharashtra state what are the total number of seats, total no of candidates, total number of parties,
--       total votes, and the breakdown of EVM and postal votes


SELECT 
    COUNT(DISTINCT cr.Constituency_Name)Total_seats,
	COUNT(DISTINCT cd.candidate)Total_candidates,
	COUNT(DISTINCT p.party_id)Total_Party,
	SUM(Evm_votes)Total_EVM_Votes,
	SUM(Postal_votes)Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID

WHERE 
    s.State = 'Maharashtra'

--                                                  PROJECT END                                                   --