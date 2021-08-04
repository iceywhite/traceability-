// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Version.java

package domain.serviceDomain;


public class Version
{

    public Version()
    {
    }

    public String toString()
    {
        return (new StringBuilder()).append("Version{owner='").append(owner).append('\'').append(", modifiedBy='").append(modifiedBy).append('\'').append(", modifiedOn='").append(modifiedOn).append('\'').append(", time='").append(time).append('\'').append(", baseline='").append(baseline).append('\'').append('}').toString();
    }

    public String getOwner()
    {
        return owner;
    }

    public void setOwner(String owner)
    {
        this.owner = owner;
    }

    public String getModifiedBy()
    {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy)
    {
        this.modifiedBy = modifiedBy;
    }

    public String getModifiedOn()
    {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn)
    {
        this.modifiedOn = modifiedOn;
    }

    public String getTime()
    {
        return time;
    }

    public void setTime(String time)
    {
        this.time = time;
    }

    public String getBaseline()
    {
        return baseline;
    }

    public void setBaseline(String baseline)
    {
        this.baseline = baseline;
    }

    private String owner;
    private String modifiedBy;
    private String modifiedOn;
    private String time;
    private String baseline;
}
