using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace ACBr.Net
{
	public sealed class ACBrAACECFs : ACBrComposedComponent, IEnumerable<ACBrAACECF>
	{
		#region Constructor

		internal ACBrAACECFs(ACBrECFIdenticacaoPaf identPaf) : base(identPaf.Parent) { }

		#endregion Constructor

		#region Properties

		public int Count
		{
			get
			{
				return GetInt32(ACBrDll.AAC_IdentPaf_ECFsAutorizados_Count);
			}
		}

		[IndexerName("GetItem")]
		public ACBrAACECF this[int index]
		{
			get
			{
				return Get(index);
			}
		}

		#endregion Properties

		#region Methods

		public void New(ACBrAACECF aacECF)
		{
			ACBrDll.TECFAutorizado item = new ACBrDll.TECFAutorizado();
			item.ValorGT = aacECF.ValorGT;
			item.NumeroSerie = aacECF.NumeroSerie;
			item.CNI = aacECF.CNI;
			item.CRO = aacECF.CRO;

			int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_New(this.Handle, item);
			CheckResult(ret);
		}

		public void Clear()
		{
			int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Clear(this.Handle);
			CheckResult(ret);
		}

		private ACBrAACECF Get(int index)
		{
			ACBrDll.TECFAutorizado item = new ACBrDll.TECFAutorizado();
			int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Get(this.Handle, ref item, index);
			CheckResult(ret);

			ACBrAACECF aacECF = new ACBrAACECF();
			aacECF.ValorGT = item.ValorGT;
			aacECF.NumeroSerie = item.NumeroSerie;
			aacECF.CNI = item.CNI;
			aacECF.CRO = item.CRO;
			aacECF.DtHrAtualizado = DateTime.FromOADate(item.DtHrAtualizado);

			return aacECF;
		}

		#endregion Methods

		#region IEnumerable<ACBrAACECF>

		public IEnumerator<ACBrAACECF> GetEnumerator()
		{
			int count = Count;
			for (int i = 0; i < count; i++)
			{
				yield return Get(i);
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return this.GetEnumerator();
		}

		#endregion IEnumerable<ACBrAACECF>
	}
}