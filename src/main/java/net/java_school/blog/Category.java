package net.java_school.blog;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Category {
    @Id public String catetory;
}