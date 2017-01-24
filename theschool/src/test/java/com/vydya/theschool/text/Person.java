package com.vydya.theschool.text;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by praveen.vydya on 5/12/2015.
 */
public class Person {
    String name, gender;
    Integer age;

     public Person(String name, String gender, Integer age) {
        this.name = name;
        this.gender = gender;
        this.age = age;
    }

    public static String print(Person p){

        return "Hi "+p.getName() +" age :"+p.getAge();
    }

    public String getWelcomeMsg() {
        return "Hello "+name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public static String getWelcomeMsg(String s) {
        return "Hi "+s;
    }

    public enum Gender {
        MALE{

            public String getGender(){
                return "M";
            }
        },
        FEMALE{

            public String getGender(){
                return "F";
            }
        },
    }

    public Person() {
    }

    public static List<Person> getPersons() {

        List<Person> persons = new ArrayList<Person>(Arrays.asList(
                new Person("Praveen","M", 24), new Person("Lakshmi","F", 19),
                new Person("Karuna","F", 20), new Person("Prakash","M", 34),
                new Person("Abdul","M", 60), new Person("Sashank","M", 24),
                new Person("Prashanthi","F", 30), new Person("Prakash","M", 24),
                new Person("Lakshmi","F", 20), new Person("Prakash","M", 34),
                new Person("Pradeep","22", 20), new Person("Rajinikanth","M", 34)

        ));
        return persons;
    }
}