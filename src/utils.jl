
function interp_rows(N::Int,tf::Float64,X::AbstractMatrix)::Matrix
    n,N1 = size(X)
    t1 = range(0,stop=tf,length=N1)
    t2 = collect(range(0,stop=tf,length=N))
    X2 = zeros(n,N)
    for i = 1:n
        interp_cubic = CubicSplineInterpolation(t1, X[i,:])
        X2[i,:] = interp_cubic(t2)
    end
    return X2
end

function ispossemidef(A)
	eigs = eigvals(A)
	if any(real(eigs) .< 0)
		return false
	else
		return true
	end
end

function convertInf!(A::VecOrMat{Float64},infbnd=1.1e20)
    infs = isinf.(A)
    A[infs] = sign.(A[infs])*infbnd
    return nothing
end

function set_logger()
    if !(global_logger() isa SolverLogger)
        global_logger(default_logger(true))
    end
end
