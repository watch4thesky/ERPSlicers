module ERPSlicers

using Statistics

export ERPSlicer, set_unique_labels!, average_epochs, std_epochs

# TODO :
# - Add more functionalties
# - Spcify types of inputs?
# - Think a bout "how" things sould be implemented. Using the ERPSlicer struct VS passing arguments directly to functions.

mutable struct ERPSlicer
    unique_labels::Vector{Any}
    # Other fields like:
    # - How to slice
    # - ...
end

ERPSlicer() = ERPSlicer([])

function set_unique_labels!(erpsl::ERPSlicer, y)
    erpsl.unique_labels = unique(y)
end

# Function that average_epochs
function average_epochs(erpsl::ERPSlicer, X, y)

    print("Small change")

    unique_labels = erpsl.unique_labels # Just test setting labels like this.

    # If we have unlabeled epochs, do average for all epochs
    if isnothing(y) == true
        X_mean = mean(X, dims=1)
        return X_mean
    end
    
    # If we dont have any unique_labels, do average for each label in y.
    if length(unique_labels) == 0
        unique_labels = unique(y)
    end
    
    # Else, do average for each label in unique_label
    X_avg = nothing
    for label in unique_labels
        index = findall(==(label),y) # index for all epochs with y=label. Use '[0]' to unpack tuple
        temp = mean(X[index,:,:], dims=1)  # shape is: (n_epochs, n_channels, n_times)
        if isnothing(X_avg) == true
            X_avg = temp
        else
            X_avg = vcat(X_avg,temp)
        end
    end
    return X_avg #, unique_labels
end

# Note: Here we send in unique_labels as argument to funciton, just to test differnt ways of doing things
function std_epochs(X, y, unique_labels)

    # Obs: Will return NaN for classes where there is only one epoch.

    # If we have unlabeled epochs, do average for all epochs
    if isnothing(y) == true
        X_std = std(X, dims=1)
        return X_std
    end
    
    # If we dont get unique_labels, do average for each label in y.
    if isnothing(unique_labels) == true
        unique_labels = unique(y)
    end
    
    # Else, do average for each label in unique_label
    X_std = nothing
    for label in unique_labels
        index = findall(==(label),y) # index for all epochs with y=label. Use '[0]' to unpack tuple
        temp = std(X[index,:,:], dims=1)  # shape is: (n_epochs, n_channels, n_times)
        if isnothing(X_std) == true
            X_std = temp
        else
            X_std = vcat(X_std,temp)
        end
    end
    return X_std 
end

function untested(X,y)
    print("This is a function that does not have test coverage.")
end


"""
Function to slice the data
"""
#function slice(X::Array{T,3}, y::Vector) where {T<:Number}
#    return nothing
#end

"""
Function set slice condition
"""
#function set_cond!(erpsl::ERPSlicer{T})
#    return nothing
#end

end