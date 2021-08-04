// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Trace.java

package domain.serviceDomain;


// Referenced classes of package domain.serviceDomain:
//            TraceElement

public class Trace
{

    public Trace()
    {
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
