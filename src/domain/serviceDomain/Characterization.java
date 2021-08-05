// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Characterization.java

package domain.serviceDomain;


public class Characterization
{

    public Characterization()
    {
    }

    public String toString()
    {
        return (new StringBuilder()).append("Characterization{type='").append(type).append('\'').append(", domain='").append(domain).append('\'').append(", granularity='").append(granularity).append('\'').append('}').toString();
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getDomain()
    {
        return domain;
    }

    public void setDomain(String domain)
    {
        this.domain = domain;
    }

    public String getGranularity()
    {
        return granularity;
    }

    public void setGranularity(String granularity)
    {
        this.granularity = granularity;
    }

    private String type;
    private String domain;
    private String granularity;
}
