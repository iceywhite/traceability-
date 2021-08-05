// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TraceabilityRoot.java

package domain.serviceDomain;


// Referenced classes of package domain.serviceDomain:
//            Constraint

public class TraceabilityRoot
{

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public Constraint getConstraint()
    {
        return constraint;
    }

    public void setConstraint(Constraint constraint)
    {
        this.constraint = constraint;
    }

    public TraceabilityRoot()
    {
    }

    private String name;
    private Constraint constraint;
}
