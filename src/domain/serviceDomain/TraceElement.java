// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TraceElement.java

package domain.serviceDomain;


// Referenced classes of package domain.serviceDomain:
//            Version, Characterization

public class TraceElement
{

    public String getUri()
    {
        return uri;
    }

    public void setUri(String uri)
    {
        this.uri = uri;
    }

    public TraceElement()
    {
        Version version = new Version();
        Characterization characterization = new Characterization();
    }

    private String uri;
}
