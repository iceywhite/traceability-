// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Constraint.java

package domain.serviceDomain;


public class Constraint
{

    public Constraint()
    {
    }

    public String toString()
    {
        return (new StringBuilder()).append("Constraint{type='").append(type).append('\'').append(", value='").append(value).append('\'').append(", language='").append(language).append('\'').append('}').toString();
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getValue()
    {
        return value;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    public String getLanguage()
    {
        return language;
    }

    public void setLanguage(String language)
    {
        this.language = language;
    }

    public void getConstraint()
    {
    }

    private String type;
    private String value;
    private String language;
}
