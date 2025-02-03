<h2><a href="https://leetcode.com/problems/team-dominance-by-pass-success">Team Dominance by Pass Success</a></h2> <img src='https://img.shields.io/badge/Difficulty-Hard-red' alt='Difficulty: Hard' /><hr><p>Table: <code>Teams</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| player_id   | int     |
| team_name   | varchar | 
+-------------+---------+
player_id is the unique key for this table.
Each row contains the unique identifier for player and the name of one of the teams participating in that match.

</pre>

<p>Table: <code>Passes</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| pass_from   | int     |
| time_stamp  | varchar |
| pass_to     | int     |
+-------------+---------+
(pass_from, time_stamp) is the primary key for this table.
pass_from is a foreign key to player_id from Teams table.
Each row represents a pass made during a match, time_stamp represents the time in minutes (00:00-90:00) when the pass was made,
pass_to is the player_id of the player receiving the pass.

</pre>

<p>Write a solution to calculate the <strong>dominance score</strong> for each team in<strong> both halves of the match</strong>. The rules are as follows:</p>

<ul>
	<li>A match is divided into two halves: <strong>first half</strong> (<code>00:00</code>-<code><font face="monospace">45:00</font></code>&nbsp;minutes) and <strong>second half </strong>(<code>45:01</code>-<code>90:00</code> minutes)</li>
	<li>The dominance score is calculated based on successful and intercepted passes:
	<ul>
		<li>When pass_to is a player from the <strong>same team</strong>: +<code>1</code> point</li>
		<li>When pass_to is a player from the <strong>opposing team</strong> (interception): <code>-1</code> point</li>
	</ul>
	</li>
	<li>A higher dominance score indicates better passing performance</li>
</ul>

<p>Return <em>the result table ordered </em><em>by</em>&nbsp;<code>team_name</code> and&nbsp;<code>half_number</code> <em>in <strong>ascending</strong> order</em>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example:</strong></p>

<div class="example-block">
<p><strong>Input:</strong></p>

<p>Teams table:</p>

<pre class="example-io">
+------------+-----------+
| player_id  | team_name |
+------------+-----------+
| 1          | Arsenal   |
| 2          | Arsenal   |
| 3          | Arsenal   |
| 4          | Chelsea   |
| 5          | Chelsea   |
| 6          | Chelsea   |
+------------+-----------+
</pre>

<p>Passes table:</p>

<pre class="example-io">
+-----------+------------+---------+
| pass_from | time_stamp | pass_to |
+-----------+------------+---------+
| 1         | 00:15      | 2       |
| 2         | 00:45      | 3       |
| 3         | 01:15      | 1       |
| 4         | 00:30      | 1       |
| 2         | 46:00      | 3       |
| 3         | 46:15      | 4       |
| 1         | 46:45      | 2       |
| 5         | 46:30      | 6       |
+-----------+------------+---------+
</pre>

<p><strong>Output:</strong></p>

<pre class="example-io">
+-----------+-------------+-----------+
| team_name | half_number | dominance |
+-----------+-------------+-----------+
| Arsenal   | 1           | 3         |
| Arsenal   | 2           | 1         |
| Chelsea   | 1           | -1        |
| Chelsea   | 2           | 1         |
+-----------+-------------+-----------+
</pre>

<p><strong>Explanation:</strong></p>

<ul>
	<li><strong>First Half (00:00-45:00):</strong>

	<ul>
		<li>Arsenal&#39;s passes:
		<ul>
			<li>1 &rarr; 2 (00:15): Successful pass (+1)</li>
			<li>2 &rarr; 3 (00:45): Successful pass (+1)</li>
			<li>3 &rarr; 1 (01:15): Successful pass (+1)</li>
		</ul>
		</li>
		<li>Chelsea&#39;s passes:
		<ul>
			<li>4 &rarr; 1 (00:30): Intercepted by Arsenal (-1)</li>
		</ul>
		</li>
	</ul>
	</li>
	<li><strong>Second Half (45:01-90:00):</strong>
	<ul>
		<li>Arsenal&#39;s passes:
		<ul>
			<li>2 &rarr; 3 (46:00): Successful pass (+1)</li>
			<li>3 &rarr; 4 (46:15): Intercepted by Chelsea (-1)</li>
			<li>1 &rarr; 2 (46:45): Successful pass (+1)</li>
		</ul>
		</li>
		<li>Chelsea&#39;s passes:
		<ul>
			<li>5 &rarr; 6 (46:30): Successful pass (+1)</li>
		</ul>
		</li>
	</ul>
	</li>
	<li>The results are ordered by team_name and then half_number</li>
</ul>
</div>
