<h2><a href="https://leetcode.com/problems/longest-team-pass-streak">Longest Team Pass Streak</a></h2> <img src='https://img.shields.io/badge/Difficulty-Hard-red' alt='Difficulty: Hard' /><hr><p>Table: <code>Teams</code></p>

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
(pass_from, time_stamp) is the unique key for this table.
pass_from is a foreign key to player_id from Teams table.
Each row represents a pass made during a match, time_stamp represents the time in minutes (00:00-90:00) when the pass was made,
pass_to is the player_id of the player receiving the pass.
</pre>

<p>Write a solution to find the <strong>longest successful pass streak</strong> for <strong>each team</strong> during the match. The rules are as follows:</p>

<ul>
	<li>A successful pass streak is defined as consecutive passes where:
	<ul>
		<li>Both the <code>pass_from</code> and <code>pass_to</code> players belong to the same team</li>
	</ul>
	</li>
	<li>A streak breaks when either:
	<ul>
		<li>The pass is intercepted (received by a player from the opposing team)</li>
	</ul>
	</li>
</ul>

<p>Return <em>the result table ordered by</em> <code>team_name</code> <em>in <strong>ascending</strong> order</em>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example:</strong></p>

<div class="example-block">
<p><strong>Input:</strong></p>

<p>Teams table:</p>

<pre>
+-----------+-----------+
| player_id | team_name |
+-----------+-----------+
| 1         | Arsenal   |
| 2         | Arsenal   |
| 3         | Arsenal   |
| 4         | Arsenal   |
| 5         | Chelsea   |
| 6         | Chelsea   |
| 7         | Chelsea   |
| 8         | Chelsea   |
+-----------+-----------+
</pre>

<p>Passes table:</p>

<pre>
+-----------+------------+---------+
| pass_from | time_stamp | pass_to |
+-----------+------------+---------+
| 1         | 00:05      | 2       |
| 2         | 00:07      | 3       |
| 3         | 00:08      | 4       |
| 4         | 00:10      | 5       |
| 6         | 00:15      | 7       |
| 7         | 00:17      | 8       |
| 8         | 00:20      | 6       |
| 6         | 00:22      | 5       |
| 1         | 00:25      | 2       |
| 2         | 00:27      | 3       |
+-----------+------------+---------+
</pre>

<p><strong>Output:</strong></p>

<pre>
+-----------+----------------+
| team_name | longest_streak |
+-----------+----------------+
| Arsenal   | 3              |
| Chelsea   | 4              |
+-----------+----------------+
</pre>

<p><strong>Explanation:</strong></p>

<ul>
	<li><strong>Arsenal</strong>&#39;s streaks:

	<ul>
		<li>First streak: 3 passes (1&rarr;2&rarr;3&rarr;4) ended when player 4 passed to Chelsea&#39;s player 5</li>
		<li>Second streak: 2 passes (1&rarr;2&rarr;3)</li>
		<li>Longest streak = 3</li>
	</ul>
	</li>
	<li><strong>Chelsea</strong>&#39;s streaks:
	<ul>
		<li>First streak: 3 passes (6&rarr;7&rarr;8&rarr;6&rarr;5)</li>
		<li>Longest streak = 4</li>
	</ul>
	</li>
</ul>
</div>
