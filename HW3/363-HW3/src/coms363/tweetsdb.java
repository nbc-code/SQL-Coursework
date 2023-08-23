package coms363;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;

import javax.swing.*;
import javax.swing.border.LineBorder;

public class tweetsdb 
{
	/*
	 * @author - Noah Cantrell, nbc@iastate.edu
	 * @author - ComS 363 Teaching staff
	 * Derived from JDBCTransactionTester which was developed by 363 Teaching staff
	 */
	public static String[] loginDialog() 
	{
		// Create dialog box
		String result[] = new String[2];
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel labelUsername = new JLabel("Username: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(labelUsername, cs);
		JTextField inputUserName = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(inputUserName, cs);

		JLabel labelPassword = new JLabel("Password: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(labelPassword, cs);
		JPasswordField inputPassword = new JPasswordField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(inputPassword, cs);
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int inputOption = JOptionPane.showOptionDialog(null, panel, "Login", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		if (inputOption == 0) // 0 means 'okay' button was pressed
		{
			//Store user-name & password
			result[0] = inputUserName.getText();
			result[1] = new String(inputPassword.getPassword());
		}
		
		return result;
	}

	/*
	 *  Finds 'k' hash-tags that appeared in the most number of states in a given year.
	 */
	private static void findPopularHashTags(Connection conn) 
	{
		if (conn==null) { throw new NullPointerException(); }
		
		// Create dialog box
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel labelHashtags = new JLabel("Number of hashtags: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(labelHashtags, cs);
		JTextField inputHashtags = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(inputHashtags, cs);

		JLabel labelYear = new JLabel("Year: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(labelYear, cs);
		JTextField inputYear = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(inputYear, cs);
		
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int inputOption = JOptionPane.showOptionDialog(null, panel, "Find Popular HashTags", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		if (inputOption == 0) // pressing the 'OK' button
		{
			try // Attempt execution of procedure
			{
				int numHashtags = Integer.parseInt(inputHashtags.getText());
				int year = Integer.parseInt(inputYear.getText());
				
				conn.setAutoCommit(false);
				conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	
				CallableStatement cstmt =conn.prepareCall("{CALL findPopularHashTags(?,?)}"); // Call the procedure
				
				cstmt.setInt(1, numHashtags); // Set Number of Hash-tags
				cstmt.setInt(2, year); // Set year
		
				// Get query results
				ResultSet queryResults = cstmt.executeQuery();
				ResultSetMetaData dataResults = queryResults.getMetaData();
				
				int colNum = dataResults.getColumnCount();
				
				//Print query results of each column
				while(queryResults.next()) 
				{
					for(int i = 1; i <= colNum; i++) 
					{
						if(i > 1) { System.out.print("| "); }
						String val = queryResults.getString(i);
						System.out.print(val + " ");
					}
					System.out.println();
				}
				
				System.out.println();
				cstmt.close();
			} 
			catch (SQLException e) 
			{
				System.out.println("Failed");
			} 
		}
	}
	
	/*
	 *  Finds 'k' most followed users of a given party.
	 */
	private static void mostFollowedUsers(Connection conn) 
	{
		if (conn==null) { throw new NullPointerException(); }
		
		// Create dialog box
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel labelNumUsers = new JLabel("Number of users: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(labelNumUsers, cs);
		JTextField inputNumUsers = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(inputNumUsers, cs);

		JLabel labelParty = new JLabel("Political Party: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(labelParty, cs);
		JTextField inputParty = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(inputParty, cs);
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int inputOption = JOptionPane.showOptionDialog(null, panel, "Most Followed Users", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		if (inputOption == 0) // pressing the 'OK' button
		{
			try // Attempt execution of procedure
			{
				int numUsers = Integer.parseInt(inputNumUsers.getText());
				String politicalParty = inputParty.getText();
				
				conn.setAutoCommit(false);
				conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	
				CallableStatement cstmt =conn.prepareCall("{CALL mostFollowedUsers(?,?)}"); // Call the procedure
				
				cstmt.setInt(1, numUsers); // Set Number of Users
				cstmt.setString(2, politicalParty); // Set Political Party
		
				// Get query results
				ResultSet queryResults = cstmt.executeQuery(); 
				ResultSetMetaData dataResults = queryResults.getMetaData();
				
				int colNum = dataResults.getColumnCount();
				
				//Print query results of each column
				while(queryResults.next()) 
				{
					for(int i = 1; i <= colNum; i++) 
					{
						if(i > 1) { System.out.print("| "); }
						String val = queryResults.getString(i);
						System.out.print(val + " ");
					}
					System.out.println();
				}
				
				System.out.println();
				cstmt.close();
			} 
			catch (SQLException e) 
			{
				System.out.println("Failed");
			} 
		}
	}
	
	/*
	 *  Inserts a new Twitter user into the users relation.
	 */
	private static void insertUser(Connection conn) 
	{
		if (conn==null) { throw new NullPointerException(); }
		
		// Create dialog box
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel labelScrName = new JLabel("Screen Name: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(labelScrName, cs);
		JTextField inputScrName = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(inputScrName, cs);

		JLabel labelUsrName = new JLabel("User Name: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(labelUsrName, cs);
		JTextField inputUsrName = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(inputUsrName, cs);
		
		JLabel labelCategory = new JLabel("Category: ");
		cs.gridx = 0;
		cs.gridy = 2;
		cs.gridwidth = 1;
		panel.add(labelCategory, cs);
		JTextField inputCategory = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 2;
		cs.gridwidth = 2;
		panel.add(inputCategory, cs);
		
		JLabel labelSubCategory = new JLabel("Subcategory: ");
		cs.gridx = 0;
		cs.gridy = 3;
		cs.gridwidth = 1;
		panel.add(labelSubCategory, cs);
		JTextField inputSubCategory = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 3;
		cs.gridwidth = 2;
		panel.add(inputSubCategory, cs);
		
		JLabel labelState = new JLabel("State: ");
		cs.gridx = 0;
		cs.gridy = 4;
		cs.gridwidth = 1;
		panel.add(labelState, cs);
		JTextField inputState = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 4;
		cs.gridwidth = 2;
		panel.add(inputState, cs);
		
		JLabel labelNumFollows = new JLabel("Number of follows: ");
		cs.gridx = 0;
		cs.gridy = 5;
		cs.gridwidth = 1;
		panel.add(labelNumFollows, cs);
		JTextField inputNumFollows = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 5;
		cs.gridwidth = 2;
		panel.add(inputNumFollows, cs);
		
		JLabel labelNumFollowing = new JLabel("Number of following: ");
		cs.gridx = 0;
		cs.gridy = 6;
		cs.gridwidth = 1;
		panel.add(labelNumFollowing, cs);
		JTextField inputNumFollowing = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 6;
		cs.gridwidth = 2;
		panel.add(inputNumFollowing, cs);
		
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int inputOption = JOptionPane.showOptionDialog(null, panel, "Insert User", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		if (inputOption == 0) // pressing the 'OK' button
		{
			try  // Attempt execution of procedure
			{
				String scrName = inputScrName.getText();
				String usrName = inputUsrName.getText();
				String category = inputCategory.getText();
				String subCategory = inputSubCategory.getText();
				String state = inputState.getText();
				int numFollows, numFollowing;
				
				// Check made for empty input values for numFollows and numFollowing
				if(inputNumFollows.getText().equals(""))
					numFollows = 0;
				else
					numFollows = Integer.parseInt(inputNumFollows.getText());
				if(inputNumFollowing.getText().equals(""))
					numFollowing = 0;
				else
					numFollowing = Integer.parseInt(inputNumFollowing.getText());
				
				int success = 0;
				
				conn.setAutoCommit(false);
				conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	
				CallableStatement cstmt =conn.prepareCall("{CALL insertUser(?,?,?,?,?,?,?,?)}"); // Call the procedure
				
				/* Empty string values in dialog box appear as "",
				 * Check for null or empty strings and set variables accordingly
				 */
				if(scrName != null && !scrName.equals("")) // Set Screen Name
					cstmt.setString(1, scrName);
				else
					cstmt.setNull(1, Types.VARCHAR);
				if(usrName != null && !usrName.equals("")) // Set User name
					cstmt.setString(2, usrName);
				else
					cstmt.setNull(2, Types.VARCHAR);
				if(category != null && !category.equals("")) // Set Category
					cstmt.setString(3, category);
				else
					cstmt.setNull(3, Types.VARCHAR);
				if(subCategory != null && !subCategory.equals("")) // Set Sub-category
					cstmt.setString(4, subCategory);
				else
					cstmt.setNull(4, Types.VARCHAR);
				if(state != null && !state.equals("")) // Set State
					cstmt.setString(5, state);
				else
					cstmt.setNull(5, Types.VARCHAR);
				
				cstmt.setInt(6, numFollows); // Set Number of Follows
				cstmt.setInt(7, numFollowing); // Set Number of Following
				cstmt.registerOutParameter(8,Types.INTEGER); //output parameter
				
				cstmt.executeUpdate();
				
				success = cstmt.getInt(8); // Update success status
				System.out.println("status " + success); // Produce success status
				
				if (success == 1) // Good insertion
				{
					System.out.println("Successful insertion of " + scrName);
					conn.commit(); // Commit on success
				}
				else // Bad insertion
				{
					System.out.print("Bad insertion - Check for duplicates");
				}
				
				System.out.println();
				cstmt.close();
			} 
			catch (SQLException e) 
			{
				System.out.println("Failed insertion of " + inputScrName.getText());
			} 
		}
	}
	
	/*
	 *  Deletes a user from the users relation given the screen name of the user as an input parameter
	 */
	private static void deleteUser(Connection conn) 
	{
		if (conn==null) { throw new NullPointerException(); }
		
		//Create dialog box
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel labelScrName = new JLabel("Screen name: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(labelScrName, cs);
		JTextField inputScrName = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(inputScrName, cs);

		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int inputOption = JOptionPane.showOptionDialog(null, panel, "Delete User", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		if (inputOption == 0) // pressing the 'OK' button
		{
			try // Attempt execution of procedure
			{
				String scrName = inputScrName.getText();
				int success = 0;
				
				conn.setAutoCommit(false);
				conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	
				CallableStatement cstmt =conn.prepareCall("{CALL deleteUser(?,?)}"); // Call the procedure
				
				cstmt.setString(1, scrName); // input parameter
				cstmt.registerOutParameter(2,Types.INTEGER); // output parameter
				
				cstmt.executeUpdate();
				
				success = cstmt.getInt(2); // set success variable
				System.out.println("status " + success); // present success status
				
				if (success == 0) { // good deletion
					System.out.println("Successful deletion of " + scrName);
					conn.commit(); // commit on success
				}
				else if(success == 1) // bad deletion
				{
					System.out.print("Bad deletion.");
				}
				else //user DNE
				{
					System.out.print("User does not exist.");
				}
				
				System.out.println();
				cstmt.close();
			} 
			catch (SQLException e)
			{
				System.out.println("Failed deletion of " + inputScrName.getText());
			}  
		}
	}
	
	/*
	 * Perform connection to database and user log-in
	 * Do stored procedure operation from the options listed
	 */
	public static void main(String[] args) {
		
		String dbServer = "jdbc:mysql://localhost:3306/practice?useSSL=true";
		String userName, password= "";

		// show the login dialog box
		String result[] = loginDialog();
		
		// only use this for debugging
		//String result[] = {"coms363", "363F2022"};
		
		//Get result set for user-name and password
		userName = result[0];
		password = result[1];

		Connection conn=null;	
		
		if (result[0]==null || result[1]==null)
		{
			System.out.println("Terminating: No username nor password is given");
			return;
		}
		
		try 
		{
			// Load JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Establish a database connection with the given userName and password
			conn = DriverManager.getConnection(dbServer, userName, password);

			// Dialog options
			String option = "";
			String instruction = "Enter A: Find 'k' hashtags that appeared in the most number of states in a given year." + "\n"
								+ "Enter B: Find 'k' most followed users of a given party." + "\n" 
								+ "Enter C: Insert a new Twitter user into the users relation." + "\n"
								+ "Enter D: Delete a user from the users relation." + "\n"
								+ "Enter E or other key to Quit Program";

			while (true) 
			{
				// show menu options
				option = JOptionPane.showInputDialog(instruction);
				
				// Reset the autocommit to commit per SQL statement
				// set the default isolation level to the default.
				conn.setAutoCommit(true);
				conn.setTransactionIsolation(Connection.TRANSACTION_REPEATABLE_READ);

				//Perform dialog options
				if (option.equals("a") || option.equals("A")) 
				{
					findPopularHashTags(conn);
				} 
				else if (option.equals("b") || option.equals("B")) 
				{
					mostFollowedUsers(conn);
				}
				else if (option.equals("c") || option.equals("C")) 
				{
					insertUser(conn);
				} 
				else if (option.equals("d") || option.equals("D"))
				{
					deleteUser(conn);
				}
				else 
				{
					break;
				}
			}

			// close the connection
			if (conn != null) { conn.close(); }
		} 
		catch (Exception e) 
		{
			System.out.println("Program terminates due to errors or user cancelation");
		}
	}

}
