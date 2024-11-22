SELECT * FROM constituencywise_details

SELECT * FROM constituencywise_results

SELECT * FROM partywise_results

SELECT * FROM statewise_results

SELECT * FROM states

--1.Total Number of Seats in 2024 Elections

SELECT 
DISTINCT COUNT (parliament_constituency) AS Total_Seats
FROM constituencywise_results

--2.What are the total number of seats available for elections in each state
SELECT 
s.state AS State_name,
COUNT (cr.parliament_Constituency) AS Total_Seats
FROM
constituencywise_results cr
INNER JOIN statewise_results sr ON cr.parliament_Constituency = sr.parliament_Constituency
INNER JOIN states s ON sr.state_id = s.state_id
GROUP BY s.state


--3.Total Seats Won by NDA Alliance

SELECT
    SUM(CASE
	        WHEN party IN (
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
			     'Sikkim Krantikari Morcha - SKM'
		      ) THEN [Won]
		      ELSE 0
	    END) AS NDA_Total_Seats_Won
FROM
    partywise_results


--4.Seats Won by NDA Alliance Parties

SELECT 
    party as Party_name,
	won as Seats_Won
FROM 
    partywise_results
WHERE 
     party IN (
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
	     'Sikkim Krantikari Morcha - SKM'
     )
ORDER BY Seats_Won DESC

--5.Total Seats Won by I.N.D.I.A. Alliance
-- Indian National Developmental Inclusive Alliance (I.N.D.I.A)
SELECT 
    SUM (CASE
	        WHEN party IN (
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
				 'Viduthalai Chiruthaigal katchi - VCK'
			) THEN [Won]
			ELSE 0
    END ) AS INDIA_Total_Seats_Won
FROM
    partywise_results


--6.Seats Won by I.N.D.I.A. Alliance Parties

SELECT 
    party as Party_name,
	won as Seats_Won
FROM 
    partywise_results
WHERE 
     party IN (
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
		  'Viduthalai Chiruthaigal katchi - VCK'
      )
ORDER BY Seats_Won DESC
   

--7.Add new column field in table partywise_results to get the party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50)

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
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
		  'Viduthalai Chiruthaigal katchi - VCK'
);

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
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
		  'Sikkim Krantikari Morcha - SKM'
);

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL ;


--8.Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT 
party_alliance,
SUM(won) as Total_Seats_Won
FROM partywise_results
GROUP BY party_alliance

--9.Winning candidates name, their party name,their alliance name, total votes, and the margin of victory for 
--a specific state and constistuency?

SELECT
cr.Winning_Candidate,
pr.party,
pr.party_alliance,
cr.total_votes,
cr.margin,
s.state,
cr.Constituency_Name
FROM
constituencywise_results cr INNER JOIN partywise_results pr ON cr.party_id = pr.party_id
INNER JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states s ON sr.state_id = s.state_id
WHERE cr.Constituency_Name = 'PUNE'


--10.What is the distribution of EVM votes Versus Postal votes for candidates in a specific constituency?

SELECT
cd.EVM_Votes,
cd.Postal_Votes,
cd.Total_Votes,
cd.Candidate,
cr.Constituency_Name
FROM constituencywise_results cr JOIN constituencywise_details cd
ON cr.Constituency_ID = cd.Constituency_ID 
WHERE cr.Constituency_Name = 'NASHIK'


--11.Which Parties won the most seats in a State, and how many seats did each party win?

SELECT
    p.Party,
	COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN
    states s ON sr.State_ID = s.State_ID
WHERE 
    s.state = 'MAHARASHTRA'
GROUP BY
    p.Party
ORDER BY
    Seats_Won DESC ;



--12.What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for 
--the India Elections 2024?

SELECT
   s.state,
   SUM(CASE WHEN pr.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
   SUM(CASE WHEN pr.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
   SUM(CASE WHEN pr.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
   FROM 
    constituencywise_results cr
JOIN
    partywise_results pr ON cr.Party_ID = pr.Party_ID
JOIN
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN
    states s ON sr.State_ID = s.State_ID
GROUP BY s.State


--13.Which candidate received the highest number of EVM votes in each constituency (Top 10) ?
SELECT TOP 10
      cr.Constituency_Name,
	  cd.Constituency_ID,
	  cd.Candidate,
	  pr.party,
	  pr.party_alliance,
	  s.state,
      cd.EVM_Votes
FROM 
      constituencywise_details cd
INNER JOIN
      constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
INNER JOIN
      partywise_results pr ON cr.Party_ID = pr.Party_ID
INNER JOIN 
      statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN 
      states s ON sr.state_id = s.state_id
WHERE 
      cd.EVM_Votes = (
	       SELECT MAX (cd1.EVM_Votes)
		   FROM constituencywise_details cd1
		   WHERE cd1.Constituency_ID = cd.Constituency_ID
	  )
ORDER BY 
        cd.EVM_Votes DESC ;



--14.Which candidate won and which candidate was the runner-up in each constituency of state for the 2024 elections?

WITH RankedCandidates AS (
     SELECT 
	     cd.Constituency_ID,
		 cd.Candidate,
		 cd.Party,
		 cd.EVM_Votes,
		 cd.Postal_Votes,
		 cd.EVM_Votes + cd.Postal_Votes  AS Total_Votes,
		 ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC ) AS VoteRank
     FROM
	     constituencywise_details cd
	 JOIN 
	     constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
	 JOIN
	     statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
	 JOIN
	     states s ON sr.State_ID = s.State_ID
	 WHERE 
	     s.State = 'MAHARASHTRA'

)
SELECT
     cr.Constituency_Name,
	 MAX (CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
	 MAX (CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
     RankedCandidates rc
JOIN 
     constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
     cr.Constituency_Name
ORDER BY
     cr.Constituency_Name; 



--15.For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties,
--total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT pr.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results pr ON cr.Party_ID = pr.Party_ID
WHERE 
    s.State = 'MAHARASHTRA';

	  

		