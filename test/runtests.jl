using ERPSlicers
using Test
using Statistics


@testset "ERPSlicers.jl" begin
# Write your tests here.

    # Some variables needed
    ch = 5
    a = 2 .*ones(3,ch,ch)
    b = 10 .*ones(2,ch,ch)
    X = vcat(a,b)
    X_avg_true = ((2*3+10*2)/(3+2)) .*ones(1,ch,ch)

    # == Tests based on all epochs ==

    # Average all epochs
    erpsl = ERPSlicer()
    X_avg = average_epochs(erpsl, X, nothing)
    @test X_avg_true == X_avg

    # Std for all epochs
    vals = [2,2,2,10,10] # Todo: use this to generate X_avg_true
    X_std_true = std(vals) .*ones(1,ch,ch)
    X_std = std_epochs(X, nothing, nothing)
    @test X_std_true ≈ X_std rtol=1e-9

    # == Test based on labels
    labels = ["c1","c2","c2","c1","c2",]

    # Average based on labels
    X_avg_c1 = ((2+10)/(2)) .*ones(1,ch,ch)
    X_avg_c2 = ((2+2+10)/(3)) .*ones(1,ch,ch)
    X_avg_labels_true = vcat(X_avg_c1, X_avg_c2)
    X_avg_labels = average_epochs(erpsl, X, labels)
    @test X_avg_labels_true ≈ X_avg_labels rtol=1e-9

    # Std based on labels
    val1 = [2,10] # Todo: use this to generate X_avg_true
    val2 = [2,2,10] # Todo: use this to generate X_avg_true
    X_std_c1 = std(val1) .*ones(1,ch,ch)
    X_std_c2 = std(val2) .*ones(1,ch,ch)
    X_std_labels_true = vcat(X_std_c1, X_std_c2)
    X_std_labels = std_epochs(X, labels, nothing)
    @test X_std_labels_true ≈ X_std_labels .+1 rtol=1e-9

   
    # == Test based on unique_labels

    # Average based on unique_labels
    u_labels1 = ["c1"]
    set_unique_labels!(erpsl, u_labels1)
    #X_avg_c1 = ((2+10)/(2)) .*ones(1,ch,ch)
    X_avg_u_labels_c1_true = X_avg_c1 #vcat(X_avg_c1, X_avg_c2)
    X_avg_u_labels_c1 = average_epochs(erpsl, X, labels)
    @test X_avg_u_labels_c1_true ≈ X_avg_u_labels_c1 rtol=1e-9

    u_labels2 = ["c2"]
    set_unique_labels!(erpsl, u_labels2)
    X_avg_c2 = ((2+2+10)/(3)) .*ones(1,ch,ch)
    X_avg_u_labels_c2_true = X_avg_c2 #vcat(X_avg_c1, X_avg_c2)
    X_avg_u_labels_c2 = average_epochs(erpsl, X, labels)
    @test X_avg_u_labels_c2_true ≈ X_avg_u_labels_c2 rtol=1e-9

    # Std based on uniqie_labels

    X_std_u_labels_c1_true = X_std_c1 #vcat(X_avg_c1, X_avg_c2)
    X_avg_u_labels_c1 = std_epochs(X, labels, u_labels1)
    @test X_std_u_labels_c1_true ≈ X_std_c1 rtol=1e-9

    X_std_u_labels_c2_true = X_std_c2 #vcat(X_avg_c1, X_avg_c2)
    X_avg_u_labels_c2 = std_epochs(X, labels, u_labels2)
    @test X_std_u_labels_c2_true ≈ X_std_c2 rtol=1e-9

    # Example test
    #@test res.y ≈ res2.y rtol=0.01
end

