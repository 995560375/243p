import java.sql.*;
import java.util.*;

public class demo {
    private static String url="jdbc:mysql://localhost:3306/DB_project_243";
    private static String user="root";
    private static String password="995560375WKzhk";
    private static Scanner scan = new Scanner(System.in);

    public static void main(String[] args) {
        printOptions();
        Scanner sc = new Scanner(System.in);
        String option = sc.nextLine().toLowerCase();
        switch (option) {
            case "1":
                System.out.println("Adding new course...");
                newCourse();
                System.out.println();
                break;
            case "2":
                System.out.println("Adding new student...");
                newStudent();
                System.out.println();
                break;
            case "3":
                System.out.println("Enrolling student in course...");
                enroll();
                System.out.println();
                break;
            case "4":
                System.out.println("Querying to see which students are in the course...");
                students();
                break;
            case "5":
                System.out.println("Querying to see which courses the student is in...");
                courses();
                break;
            case "6":
                System.out.println("Querying to see course schedule...");
                time();
                break;
            case "0":
                System.out.println("Exiting Program...");
                break;
        }
    }

    public static void printOptions() {
        System.out.println("+---------------------------------------------------+");
        System.out.println("| Select from options below:                        |");
        System.out.println("| 1. Add a new course                               |");
        System.out.println("| 2. Add a new student                              |");
        System.out.println("| 3. Enroll student in a course                     |");
        System.out.println("| 4. Query student list for a given course          |");
        System.out.println("| 5. Query course list for a given student          |");
        System.out.println("| 6. Query student schedule on a given day          |");
        System.out.println("| 0. Exit program                                   |");
        System.out.println("+---------------------------------------------------+");
    }

    public static void newCourse() {
        System.out.println("name");
        String name = scan.nextLine().toLowerCase();
        System.out.println("day");
        String time = scan.nextLine().toLowerCase();
        System.out.println("time");
        String time2 = scan.nextLine().toLowerCase();
        InsertCourse(name, time, time2);
        System.out.println("Success");
    }

    public static void newStudent() {
        System.out.println("name");
        String name = scan.nextLine().toLowerCase();

        InsertStudent(name);
        System.out.println("Success");
    }

    public static void enroll() {
        System.out.println("Student id");
        String sid = scan.nextLine().toLowerCase();
        System.out.println("Course id");
        String cid = scan.nextLine().toLowerCase();

        InsertLink(Integer.parseInt(sid), Integer.parseInt(cid));
        System.out.println("Success");
    }

    public static void students() {
        System.out.println("Course id");
        String cid = scan.nextLine().toLowerCase();
        selectStudents(Integer.parseInt(cid));
        System.out.println("Success");
    }

    public static void courses() {
        System.out.println("Student id");
        String sid = scan.nextLine().toLowerCase();
        selectCourses(Integer.parseInt(sid));
        System.out.println("Success");
    }

    public static void time() {
        System.out.println("Student id");
        String sid = scan.nextLine().toLowerCase();
        System.out.println("day");
        String day = scan.nextLine().toLowerCase();
        selectTime(Integer.parseInt(sid), day);
        System.out.println("Success");
    }


    public static void InsertCourse(String name, String time, String time2) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn=null;
        PreparedStatement ps=null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="insert into courses values(default, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, time);
            ps.setString(3, time2);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }

    public static void InsertStudent(String name) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn=null;
        PreparedStatement ps=null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="insert into students values(default, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }

    public static void InsertLink(int sid, int cid) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn=null;
        PreparedStatement ps=null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="insert into link values(?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
            ps.setInt(2, cid);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }

    public static void selectStudents(int sid) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="select course_name, student_name\n" +
                    "from courses c join link l\n" +
                    "on c.course_id = l.course_id\n" +
                    "join students s\n" +
                    "on l.student_id = s.student_id\n" +
                    "where c.course_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
//            stat=conn.createStatement();
//            rs = stat.executeQuery(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                String courseName = rs.getString("course_name");
                String studentName = rs.getString("student_name");
                System.out.println("course: " + courseName + " student: " + studentName);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                stat.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void selectCourses(int sid) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="select student_name, course_name\n" +
                    "from students s join link l\n" +
                    "\ton s.student_id = l.student_id\n" +
                    "    join courses c \n" +
                    "    on l.course_id = c.course_id\n" +
                    "where s.student_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
//            stat=conn.createStatement();
//            rs = stat.executeQuery(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                String courseName = rs.getString("course_name");
                String studentName = rs.getString("student_name");
                System.out.println("course: " + courseName + " student: " + studentName);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                stat.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void selectTime(int sid, String time) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        PreparedStatement ps = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            String sql="select student_name, course_name, course_time2\n" +
                    "from students s join link l\n" +
                    "on s.student_id = l.student_id\n" +
                    "join courses c \n" +
                    "on l.course_id = c.course_id\n" +
                    "where s.student_id = ? and c.course_time = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
            ps.setString(2, time);
//            stat=conn.createStatement();
//            rs = stat.executeQuery(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                String courseName = rs.getString("course_name");
                String studentName = rs.getString("student_name");
                String courseTime = rs.getString("course_time2");
                System.out.println("course: " + courseName + " student: " + studentName + " time: " +courseTime);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{

            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                stat.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
