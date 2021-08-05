// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Artifact.java

package domain.serviceDomain;


// Referenced classes of package domain.serviceDomain:
//            TraceElement

public class Artifact
{

    public Artifact()
    {
    }

    public String toString()
    {
        return (new StringBuilder()).append("Artifact{traceElement=").append(traceElement).append('}').toString();
    }

    public TraceElement getTraceElement()
    {
        return traceElement;
    }

    public void setTraceElement(TraceElement traceElement)
    {
        this.traceElement = traceElement;
    }

    private TraceElement traceElement;
}
