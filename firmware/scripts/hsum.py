
# Test of ROOT updating histograms.

# hsum1.C ( using Root interpreter ) takes 7.1 seconds for 100,000 fills and 200 updates (using gBenchmark).
# hsum.py takes 4.9s (using time).


from ROOT import TCanvas, TF1 , TH1F , gRandom , gBenchmark 

def hsum():

    c1 = TCanvas("c1","The HSUM example",200,10,600,400)

    c1.SetGrid()

    s1 = TH1F("s1","This is the first signal",100,-4,4)

    s1.SetFillColor(42)

    gRandom.SetSeed()

    kUPDATE = 500

    for i in range (0,100000):

        xs1   = gRandom.Gaus(-0.5,0.5)

        s1.Fill(xs1,0.3)


        if (i and ((i%kUPDATE) == 0) ):

            if (i == kUPDATE):

                s1.Draw("same")
                c1.Update()

        

            c1.Modified()
            c1.Update()

    c1.Modified()
    gBenchmark.Show("hsum")

hsum()
